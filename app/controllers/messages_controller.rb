class MessagesController < ApplicationController
  GATHERING_PROMPT = <<~PROMPT
    You are a professional fitness coach having a friendly conversation with a user to understand their needs before building a workout routine.

    Your goal is to gather the following information naturally through conversation:
    - What body parts or muscles they want to target
    - Their fitness level (beginner, intermediate, advanced)
    - Available equipment (none, dumbbells, gym, resistance bands, etc.)
    - Any injuries or physical constraints
    - Their main objective (strength, endurance, weight loss, flexibility, etc.)

    RULES:
    - You have a maximum of 3 messages to ask questions. After your 3rd message with questions, you must generate the exercises regardless of how much information you have.
    - Ask one or two questions at a time, not all at once.
    - Be friendly and concise.
    - Do NOT generate exercises yet.
    - Do NOT output JSON.
    - Once you have enough context (within your 3 message limit), OR if the user explicitly asks to generate exercises, end your message with exactly this token on its own line:
      READY_TO_GENERATE
    - Your 3rd question message must always end with READY_TO_GENERATE, as it is your last allowed message before generating.
    - Do not explain the token. Just append it at the end of your last conversational message.
  PROMPT

  GENERATION_PROMPT = <<~PROMPT
    You are a professional fitness coach.

    The user wants to build a sports routine perfectly adapted to their needs.

    Your task is to provide exactly 3 exercises that strictly match the user's request (goal, level, body part, available equipment, physical constraints, etc.).

    STRICT RULES:
    - You must provide exactly 3 exercises.
    - You must not ask questions.
    - You must not add explanations outside of the JSON structure.
    - You must not suggest warm-ups, full programs, or nutrition advice.
    - You must not write anything outside of the required JSON structure.
    - Your entire response must be valid JSON.
    - Do not wrap the JSON in markdown.
    - Do not include backticks.
    - Do not include comments.
    - Do not include trailing commas.

    VIDEO LINK RULES (ANTI-HALLUCINATION):
    - Only provide real and publicly accessible video URLs.
    - Only use valid YouTube links in this exact format: https://www.youtube.com/watch?v=VIDEO_ID
    - If you are not 100% certain the video exists, use: https://www.youtube.com/results?search_query=EXERCISE_NAME+exercise
    - Never output a broken or fake URL.

    DESCRIPTION RULES:
    - The description must clearly explain how to perform the exercise.
    - It must be concise (1-3 sentences maximum).
    - It must describe posture, movement, and key execution cues.

    REQUIRED OUTPUT FORMAT (STRICT JSON ARRAY):
    [
      {
        "name": "Exercise Name",
        "description": "How to perform the exercise.",
        "reps": "X repetitions or X seconds",
        "objective": "Targeted muscle(s) or specific training goal",
        "video_url": "https://www.youtube.com/watch?v=VIDEO_ID"
      }
    ]

    Return only the JSON array.
  PROMPT

  def new
    @message = Message.new
  end

  def create
    @chat = current_user.chats.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      if routine_request?
        handle_routine_addition
      elsif gathering_phase?
        handle_gathering
      else
        handle_generation
      end

      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def gathering_phase?
    assistant_question_count = @chat.messages.where(role: "assistant").count
    assistant_question_count < 3 || @chat.messages.where(role: "assistant").none? do |m|
      JSON.parse(m.content) rescue false
    end
  end

  def handle_gathering
    ruby_llm_chat = RubyLLM.chat

    history = @chat.messages.order(:created_at).map do |m|
      "#{m.role.capitalize}: #{m.content}"
    end.join("\n")

    assistant_question_count = @chat.messages.where(role: "assistant").count

    if assistant_question_count >= 3
      Message.create!(
        role: "assistant",
        content: "Great, I have everything I need! Here are the exercises I recommend for you:",
        chat: @chat
      )
      handle_generation
      return
    end

    response = ruby_llm_chat.with_instructions(GATHERING_PROMPT).ask(history)
    response_text = response.content

    if response_text.include?("READY_TO_GENERATE")
      clean_response = response_text.gsub("READY_TO_GENERATE", "").strip
      Message.create!(role: "assistant", content: clean_response, chat: @chat) unless clean_response.blank?
    else
      Message.create!(role: "assistant", content: response_text, chat: @chat)
    end
  end

  def handle_generation
    ruby_llm_chat = RubyLLM.chat

    history = @chat.messages.order(:created_at)
                   .map { |m| "#{m.role.capitalize}: #{m.content}" }
                   .join("\n")

    response = ruby_llm_chat.with_instructions(GENERATION_PROMPT).ask(history)
    response_content = JSON.parse(response.content)

    @exercices = response_content.map do |e|
      Exercice.create!({
        description: e["description"],
        name: e["name"],
        objective: e["objective"],
        rep_amount: e["reps"],
        video_url: e["video_url"],
        routine_id: nil,
        chat_id: @chat.id
      })
    end

    @exercices.each do |e|
      Message.create!(
        role: "assistant",
        content: {
          name: e.name,
          description: e.description,
          rep_amount: e.rep_amount,
          objective: e.objective,
          video_url: e.video_url
        }.to_json,
        chat: @chat
      )
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def routine_request?
    exercises_generated = @chat.exercices.exists?
    user_message = @message.content.downcase
    exercises_generated && user_message.match?(/add|routine|save|put/)
  end

  def handle_routine_addition
    tool = AddExercicesToRoutine.new(chat: @chat, user: current_user)

    routine_names = current_user.routines.pluck(:name).join(", ")

    response = RubyLLM.chat.with_instructions("You help users add exercises to their routines.
    Available routines: #{routine_names}. Use the add_exercices_to_routine tool.").with_tool(tool).ask(@message.content)

    Message.create!(role: "assistant", content: response.content, chat: @chat)
  end
end

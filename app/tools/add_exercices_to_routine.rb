class AddExercicesToRoutine < RubyLLM::Tool
  description "Add the exercises present in the chat to the routine specified by the user"
  param :routine_name, desc: "The name of the routine to which we want to add the exercises"

  def initialize(chat:, user:)
    @chat = chat
    @user = user
  end

  def execute(routine_name:)
    routine = @user.routines.find_by(name: routine_name)
    return "Routine '#{routine_name}' not found." unless routine

    exercises = @chat.messages.where(role: "assistant").filter_map do |message|
        JSON.parse(message.content)
      rescue JSON::ParserError
        nil
    end
    .filter_map { |hash| @chat.exercices.find_by(name: hash["name"]) }

    return "No exercises found in this chat." if exercises.empty?

    exercises.each { |exercise| exercise.update(routine_id: routine.id) }

    "Successfully added #{exercises.count} exercise(s) to '#{routine.name}': #{exercises.map(&:name).join(', ')}."
  end
end

class ChatsController < ApplicationController

  def create
    @chat = Chat.new
    @chat.user = current_user

    if @chat.save
      redirect_to chat_path(@chat)
    else
      redirct_to root_path
    end
  end

  def show
    @chat    = current_user.chats.find(params[:id])
    @message = Message.new
  end
end

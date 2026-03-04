class ChatsController < ApplicationController

  def create
    @chat = Chat.new
    @chat.user = current_user

    if @chat.save
      redirect_to chat_path(@chat)
    else
      redirect_to root_path
    end
  end

  def show
    @chat    = current_user.chats.find(params[:id])
    @message = Message.new
    @routines = current_user.routines # Devrait pas être dans cette page, mais fonctionne.
  end
end

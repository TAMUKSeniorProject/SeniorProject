class ConversationsController < ApplicationController
  def index
    @conversations = User.mailbox.conversations
    #@conversations = current_user.mailbox.conversations
  end
  
  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end
  
  def new
    @recipients = User.all - [current_user]
  end
  
  def create
    recipient = User.find(params[:user_id])
    reciept = current_user.send_message(recipient, params[:body], params[:subject])
    redirect_to conversation_path(reciept.conversation)
  end
end

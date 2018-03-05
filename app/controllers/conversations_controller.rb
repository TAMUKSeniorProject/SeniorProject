class ConversationsController < ApplicationController
  
  def index
    @conversations = current_user.mailbox.conversations
    #current_user.mailbox.conversations.first.becomes(::Conversation) 
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

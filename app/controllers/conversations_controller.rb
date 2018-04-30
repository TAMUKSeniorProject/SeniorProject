class ConversationsController < ApplicationController
  
  def new
  end
  
  # require 'will_paginate/array' 
  # def index
  # @conversations = conversation.paginate(:page => params[:page], per_page: 3)
  # # @messages = message.paginate(:page => params[:page], per_page: 3)
  # end
  
  def create
    recipients = User.where(id: conversation_params[:recipients])
    conversation = current_user.send_message(recipients, conversation_params[:body], conversation_params[:subject]).conversation
    flash[:success] = "Your message was successfully sent!"
    redirect_to conversation_path(conversation)
  end
  
  def show
    @receipts = conversation.receipts_for(current_user)
    # mark conversation as read
    conversation.mark_as_read(current_user)
  end
  
  def reply
    current_user.reply_to_conversation(conversation, message_params[:body])
    flash[:notice] = "Your reply message was successfully sent!"
    redirect_to conversation_path(conversation)
  end
  
  def trash
    conversation.move_to_trash(current_user)
    redirect_to mailbox_inbox_path
  end
  
  def untrash
    conversation.untrash(current_user)
    redirect_to mailbox_inbox_path
  end
  
  def empty_trash
    current_user.mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    flash[:success] = 'Your trash was cleaned!'
    redirect_to mailbox_inbox_path
  end

  
  
  private
  def conversation_params
    params.require(:conversation).permit(:subject, :body,recipients:[])
  end
  
  def message_params
    params.require(:message).permit(:body, :subject)
  end
end

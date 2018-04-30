class MailboxController < ApplicationController
    before_action :authenticate_user!

  require 'will_paginate/array' 
  # def index
  # @conversations = conversation.paginate(:page => params[:page], per_page: 3)
  # # @messages = message.paginate(:page => params[:page], per_page: 3)
  # end
  
  
  def inbox
    @inbox = mailbox.inbox
    @active = :inbox
  end

  def sent
    @sent = mailbox.sentbox.paginate(:page => params[:page], per_page: 3)
    @active = :sent
  end

  def trash
    @trash = mailbox.trash.paginate(:page => params[:page], per_page: 3)
    @active = :trash
  end
  
end

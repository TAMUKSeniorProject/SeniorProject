class NotificationsController < ApplicationController
    before_action :authenticate_user!
    
    def index 
        @notifications = Notification.where(recipient: current_user).unread
    end
    
    def mark_as read 
        @notifications = Notification.where(recipient: current_user).unread 
        @notifications.update.all(read_at: Time.zone.now)
        render json: {success: true}
    end 
end
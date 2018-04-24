class ModerationController < ApplicationController
    #before_action :set_discussion, only: [:show]
    
    def index
        @discussions = Discussion.joins(:user).where(users: {first_post_approved: false}).order('discussions.created_at desc')
        #@user = User.find(current_user.id)
    end
    
    def show
        @discussions = Discussion.all.order('created_at desc')
    end
    
    def approve_fp
        @user = User.joins(:discussions).where(discussions: {id: @discussion.id})
        @user.first_post_approved = true
        @user.save
    end
    
    
    private
        # Use callbacks to share common setup or constraints between actions.
        def set_discussion
          @discussion = Discussion.find(params[:id])
        end
end
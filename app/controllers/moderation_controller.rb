class ModerationController < ApplicationController
    before_action :set_discussion, only: [:approve_fp]
    before_action :discussion_params, only: [:approve_fp]
    
    def index
        @discussions = Discussion.joins(:user).where(users: {first_post_approved: false}).order('discussions.created_at desc')
        #@user = User.find(current_user.id)
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
        
        def discussion_params
            params.permit(:id)
        end
end
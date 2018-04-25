class ModerationController < ApplicationController
    def index
        @discussions = Discussion.joins(:user).where(users: {first_post_approved: false}).order('discussions.created_at desc')
        #@user = User.find(current_user.id)
    end
end
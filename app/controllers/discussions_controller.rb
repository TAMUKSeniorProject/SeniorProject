class DiscussionsController < ApplicationController
  include ApplicationHelper
  before_action :set_discussion, only: [:show, :edit, :update, :destroy, :approve_fp]
  before_action :find_channels, only: [:index, :show, :new, :edit]
  # except on the index and show views, you need to be logged in as a user.
  before_action :authenticate_user!, except: [:index, :show, :approve_fp]
  
  # GET /discussions
  # GET /discussions.json
  def index
    @q = Discussion.ransack(params[:q])
    if params[:tag]
      @discussions = Discussion.tagged_with(params[:tag]).order('created_at desc')
    # elsif params[:query].present?
    #   @discussions = Discussion.quick_search(params[:query]).order('created_at desc')
    
    elsif params[:q]
      @discussions = @q.result(distinct: true)
    else
      #@discussions = Discussion.all.order('created_at desc')
      #@discussions = Discussion.joins(:users).where(users: { id: current_user.id }).order('discussions.created_at desc')
      @discussions = Discussion.joins(:user).where(users: { first_post_approved: true }).order('discussions.created_at desc')
      #@user = User.find(current_user.id)
      #@discussions = @user.discussion.all.order('created_at desc')
    end
  end

  # GET /discussions/1
  # GET /discussions/1.json
  def show
    @q = Discussion.ransack(params[:q])
    @discussions = Discussion.all.order('created_at desc')
  end

  # GET /discussions/new
  def new
    @q = Discussion.ransack(params[:q])
    @discussion = current_user.discussions.build
  end

  # GET /discussions/1/edit
  def edit
    @q = Discussion.ransack(params[:q])
    #prevent users from trying to manually change someone else's discussion post...unless they are an admin user.
    redirect_to(root_url) unless @discussion.user_id == current_user.id || has_role?(:admin)
  end

  # POST /discussions
  # POST /discussions.json
  def create
    @q = Discussion.ransack(params[:q])
    @discussion = current_user.discussions.build(discussion_params)

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to @discussion, notice: 'Discussion was successfully created.' }
        format.json { render :show, status: :created, location: @discussion }
      else
        format.html { render :new }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discussions/1
  # PATCH/PUT /discussions/1.json
  def update
    @q = Discussion.ransack(params[:q])
    respond_to do |format|
      if @discussion.update(discussion_params)
        format.html { redirect_to @discussion, notice: 'Discussion was successfully updated.' }
        format.json { render :show, status: :ok, location: @discussion }
      else
        format.html { render :edit }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussions/1
  # DELETE /discussions/1.json
  def destroy
    @q = Discussion.ransack(params[:q])
    @discussion.destroy
    respond_to do |format|
      format.html { redirect_to discussions_url, notice: 'Discussion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # def moderate
  #   @discussions = Discussion.joins(:user).where(users: {first_post_approved: false}).order('discussions.created_at desc')
  # end
  
  def approve_fp
    #redirect_to root_url
    user = User.joins(:discussions).where(discussions: {id: @discussion.id})
    user.update_all(:first_post_approved => true)
    redirect_to moderation_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discussion
      @discussion = Discussion.find(params[:id])
    end
    
    def find_channels
      @channels = Channel.all.order('created_at desc')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discussion_params
      params.require(:discussion).permit(:title, :content, :channel_id, :start_time, :topic_list => [])
    end
    
end

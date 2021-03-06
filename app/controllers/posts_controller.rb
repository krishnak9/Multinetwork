class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]


  def index
    @posts = Post.all
  end


  def show
  end


  def new
    @post = Post.new
  end


  def edit
  end


  def create
  @post = Post.new(post_params) do |post|
    post.user = current_user
  end
  if @post.save
    redirect_to posts_url
  else
    redirect_to root_path, notice: @post.errors.full_messages.first
  end
end



  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def upvote
    @posts = Post.find(params[:id])
    @posts.upvote_by current_user
    redirect_to :back
  end
  def downvote
    @posts = Post.find(params[:id])
    @posts.downvote_by current_user
    redirect_to :back
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end


    def post_params
      params.require(:post).permit(:attachment, :content, :user_id)
    end
end

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def top
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @posts = Post.paginate(page: params[:page], :per_page => 1)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show

    @favorite = current_user.favorites.find_by(post_id: @post.id)
    @comments = @post.comments.includes(:user).all

    @comment = Comment.new
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
    #binding.pry

  end

  # GET /posts/new
  def new
    if params[:back]
      @post = Post.new
      @post.image.retrieve_from_cache! params[:cache][:image]
    else
      @post = Post.new
    end
  end

  def confirm
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    render "new" if @post.invalid?
  end

  # GET /posts/1/edit
  def edit
    
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.image.retrieve_from_cache! params[:cache][:image]
    respond_to do |format|
      if @post.save
        ContactMailer.post_mail(@post).deliver
        format.html { redirect_to @post, notice: '投稿が完了しました！' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
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

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      #raise
      #binding pry
      params.require(:post).permit(:content, :image, :user_id, :image_cache)
    end
end

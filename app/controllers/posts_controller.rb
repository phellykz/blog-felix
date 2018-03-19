class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :authenticate_user!
  # GET /posts
  # GET /posts.json
  def index
    if params[:search]
      @posts = Post.search(params[:search])
      respond_to do |format|
        format.html
        format.csv { send_data @posts.to_csv}
        format.xls
      end
    else
      @posts = Post.all.order('created_at DESC')
      respond_to do |format|
        format.html
        format.csv { send_data @posts.to_csv}
        format.xls 
        
      end
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    
    if @post.update(params[:post].permit(:title, :body, :avatar))
      redirect_to @post
    else
      render 'edit'
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
      @post = Post.with_deleted.find(params[:id])
    if params[:type] == 'normal'
      @post.destroy
    elsif params[:type] == 'forever'
      @post.really_destroy!
    elsif params[:type] == 'undelete'
      @post.restore
    end

    redirect_to posts_path
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :avatar)
    end
end

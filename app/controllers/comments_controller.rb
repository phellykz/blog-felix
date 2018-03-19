class CommentsController < ApplicationController
  
  before_action :authenticate_user!

    def index
      @comments = Comment.all.order('created_at DESC')
    end
  
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.create(params[:comment].permit(:name, :body))

      redirect_to post_path(@post)
    end

    def destroy
      #@post = Post.find(params[:post_id])
      #@comment = @post.comments.find(params[:id])
      #@comment.destroy

      #redirect_to post_path(@post)


      @post = Post.find(params[:post_id])
      @comment = @post.comments.with_deleted.find(params[:id])
      #@post = Post.with_deleted.find(params[:id])

      if params[:type] == 'normal'
        @comment.destroy
      elsif params[:type] == 'forever'
        @comment.really_destroy!
      elsif params[:type] == 'undelete'
      @comment.restore
    end

    redirect_to post_path(@post)
    end
end

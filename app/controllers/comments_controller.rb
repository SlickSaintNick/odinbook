class CommentsController < ApplicationController
  before_action :set_post

  def new
    @comment = @post.comments.build
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @comment.comment_reply_id = params[:comment_id]

    if @comment.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :status)
  end
end

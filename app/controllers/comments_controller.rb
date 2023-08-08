class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @commentable.comments.build(comment_params)
    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end

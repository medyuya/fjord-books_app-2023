class CommentsController < ApplicationController
  def create
    @comment = @commentable.comments.build(comment_params)
    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      # コメント作成失敗時の処理は後述
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end

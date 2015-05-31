class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_parent, except: :destroy
  before_action :load_comment, only: :destroy

  respond_to :js

  def create
    respond_with(@comment = @parent.comments.create(comment_params))
  end

  def destroy
    @comment.destroy
    redirect_to :back
  end

  private

  def load_parent
    @parent = Question.find(params[:question_id]) if params[:question_id]
    @parent ||= Answer.find(params[:answer_id])
  end

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end
end
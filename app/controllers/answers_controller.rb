class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_answer, only: [:update, :destroy]
  after_action :publish_answer, only: :create

  respond_to :js
  respond_to :json, only: :create

  def create
    @question = Question.find(params[:question_id])
    respond_with(@answer = @question.answers.create(answer_params))
  end

  def update
    @answer.update(answer_params)
  end

  def destroy
    if @answer.destroy!
      redirect_to question_path(@answer.question)
    end
  end

  private

  def publish_answer
    PrivatePub.publish_to("/questions/#{@question.id}/answers", answer: @answer.to_json) if @answer.valid?
  end

  def load_answer
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file]).merge(user: current_user)
  end
end
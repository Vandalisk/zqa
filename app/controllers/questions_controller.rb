class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
	before_action :load_question, only: [:show, :edit, :update, :destroy]  
  before_action :build_answer, only: :show

  respond_to :html

  authorize_resource

  def index
    respond_with(@questions = Question.search(params[:search]))
  end

  def show
    respond_with @question
  end

  def new
   respond_with(@question = Question.new)
  end

  def edit
  end

  def create
	 @question = Question.new(question_params)
   
   @question.user = current_user

   if @question.save
    flash[:notice] = 'Your question successfully created.'
	  redirect_to @question
	 else
	  render :new
	 end

  end

  def update
    @question.update(question_params)
    respond_with @question
  end

  def destroy
	  respond_with(@question.destroy)	 
  end

  private

  def load_question
	 @question = Question.find(params[:id])
  end

  def build_answer
    @answer = @question.answers.build
  end

  def question_params
	 params.require(:question).permit(:title, :body, attachments_attributes: [:file])
  end
end

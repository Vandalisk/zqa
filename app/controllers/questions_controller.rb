class QuestionsController < ApplicationController
	before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :build_answer, only: :show

  def index
   respond_with(@questions = Question.all)
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

  # flash[:notice] = 'Your question successfully created.' if @question.save
	# respond_with @question

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

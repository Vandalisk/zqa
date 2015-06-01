class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
	before_action :load_question, only: [:show, :edit, :update, :destroy]  
  before_action :build_answer, only: :show
  before_action :set_user_language, only: [:index]

  respond_to :html, :json

  authorize_resource

  def index
    respond_with(@questions = Question.search(params[:search], :page => params[:page]))
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

  def set_user_language
    I18n.locale = params[:language]
  end

  def load_question
	 @question = Question.find(params[:id])
  end

  def build_answer
    @answer = @question.answers.build
  end

  def question_params
	 params.require(:question).permit(:title, :body, :tag_list, attachments_attributes: [:file])
  end
end

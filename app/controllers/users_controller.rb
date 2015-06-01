class UsersController < ApplicationController

	respond_to :html, :json

  def index
  	@users = User.all.paginate(page: params[:page])
  end

  def show
  	respond_with @user = User.find(params[:id])
  end

  def edit
  end
end

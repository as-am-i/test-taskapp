class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def show
  	@user = User.find_by(id: params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(name: params[:name], email: params[:email])
  	if @user.save
  		flash[:notice] = "Welcome, #{@user.name}. You have signed up successfully!"
  		redirect_to("/users/#{@user.id}")
  	else
  		render("/users/new")
  	end
  end

  def edit
  	@user = User.find_by(id: params[:id])
  end

  def update
  	@user = User.find_by(id: params[:id])
  	@user.name = params[:name]
  	@user.email = params[:email]
  	if @user.save
  		flash[:notice] = "your information updated successfully!"
  		redirect_to("/users/#{@user.id}")
  	else
  		render("/users/edit")
  	end
  end
end

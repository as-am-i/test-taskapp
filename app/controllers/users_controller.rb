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
  	@user = User.new(
  		name: params[:name],
  		email: params[:email],
  		image_name: "default_user.png",
  		password: params[:password]
  	)
  	if @user.save
  		session[:user_id] = @user.id # make the user singned in
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

  	if params[:image]
  		@user.image_name = "#{@user.id}.jpg"
  		image = params[:image]
  		File.binwrite("public/user_images/#{@user.image_name}", image.read)
  	end

  	if @user.save
  		flash[:notice] = "your information updated successfully!"
  		redirect_to("/users/#{@user.id}")
  	else
  		render("/users/edit")
  	end
  end

  def destroy
  	@user = User.find_by(id: params[:id])
	@user.destroy
	flash[:notice] = "your account deleted successfully!"
	redirect_to("/users")
  end

  def login_form
  end

  def login
  	@user = User.find_by(email: params[:email], password: params[:password])

  	if @user
  		session[:user_id] = @user.id

  		flash[:notice] = "You are successfully signed in."
  		redirect_to("/tasks")
  	else
  		@error = "Your email/password invalid"

  		@email = params[:email]
  		@password = params[:password]

  		render("/users/login_form")
  	end
  end

  def logout
  	session[:user_id] = nil
  	flash[:notice] = "You are successfully signed out."
  	redirect_to("/signin")
  end

end

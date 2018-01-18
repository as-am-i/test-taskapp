class TasksController < ApplicationController
	def index
		@tasks = Task.all.order(created_at: :desc)
	end

	def show
		@task = Task.find_by(id: params[:id])
	end

	def new
		@task = Task.new
	end

	def create
		@task = Task.new(title: params[:title])
		if @task.save
			flash[:notice] = "your task sent successfully!"
			redirect_to("/tasks")
		else
			render("/tasks/new")
		end
	end

	def edit
		@task = Task.find_by(id: params[:id])
	end

	def update
		@task = Task.find_by(id: params[:id])
		@task.title = params[:title]
		if @task.save
			flash[:notice] = "your task updated successfully!"
			redirect_to("/tasks")
		else
			render("/tasks/edit")
		end
	end

	def destroy
		@task = Task.find_by(id: params[:id])
		@task.destroy
		flash[:notice] = "your task deleted successfully!"
		redirect_to("/tasks")
	end
end

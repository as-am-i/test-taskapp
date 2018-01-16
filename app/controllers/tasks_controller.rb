class TasksController < ApplicationController
	def index
		@tasks = Task.all.order(created_at: :desc)
	end

	def show
		@task = Task.find_by(id: params[:id])
	end

end

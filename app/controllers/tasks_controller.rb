class TasksController < ApplicationController
	def index
		@tasks = Task.all.order(created_at: :desc)
	end

	def show

	end

end

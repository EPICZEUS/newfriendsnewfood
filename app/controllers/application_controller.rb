class ApplicationController < ActionController::Base
	before_action :current_user, except: [:login, :new, :logging, :create]

	def current_user
		# byebug
		puts "doin things"
		if session[:user_id]
			@current_user = User.find(session[:user_id])
		else
			redirect_to root_path
		end
	end
end
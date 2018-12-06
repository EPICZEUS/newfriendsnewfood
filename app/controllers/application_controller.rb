class ApplicationController < ActionController::Base
	before_action :current_user

	def current_user
		# byebug
		if session[:user_id] && User.all.any? { |e| e.id == session[:user_id] }
			@current_user = User.find(session[:user_id])
		else
			session[:user_id] = nil
			redirect_to root_path
		end
	end
end
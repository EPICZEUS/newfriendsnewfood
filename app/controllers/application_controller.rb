class ApplicationController < ActionController::Base
	before_action :authorized
	helper_method :current_user
	helper_method :logged_in?

	def current_user
		User.find_by(id: session[:user_id])
	end

	def logged_in?
		!!current_user
	end

	def authorized
		# byebug
		unless logged_in?
			redirect_to root_path
		end
	end
end
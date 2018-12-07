class UsersController < ApplicationController
	skip_before_action :authorized, only: [:login, :new, :connect, :create]
	before_action :find_user, only: [:show, :edit, :update, :destroy]
	before_action :anti_login, only: [:login, :new]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.create(user_params)

		if @user.valid?
			session[:user_id] = @user.id
			redirect_to @user
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to new_user_path
		end
	end

	def update
		@user.update(user_params)

		if @user.valid?
			redirect_to @user
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to edit_user_path
		end
	end

	def destroy
		@user.destroy
		session[:user_id] = nil
		redirect_to users_path
	end

	def login
		# byebug
		if params[:login]
			data = params[:login]

			@user = User.find_by(username: data[:username])

			if @user && @user.authenticate(data[:password])
				session[:user_id] = @user.id
				redirect_to @user
			else
				flash[:errors] = ["Username or Password is incorrect"]
				redirect_to root_path
			end
		end
	end

	def logout
		session[:user_id] = nil
		redirect_to root_path
	end

	def show
	end

	def edit
		redirect_to current_user unless current_user == @user
	end

	private

	def find_user
		# byebug
		@user = User.find(params[:id])
	end

	def anti_login
		# byebug
		if logged_in?
			redirect_to user_path(session[:user_id])
		end
	end

	def user_params
		params.require(:user).permit(:name, :age, :username, :password, :password_confirmation, :img_url, :bio)
	end
end

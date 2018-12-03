class UsersController < ApplicationController
	before_each :find_user, only: [:show, :edit, :update, :destroy]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.create(user_params)

		if @user.valid?
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
		redirect_to users_path
	end

	def show
	end

	def edit
	end

	private

	def find_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:name, :age, :username, :img_url, :bio)
	end
end

class MessagesController < ApplicationController
	# before_each :find_message, only: [:show, :edit, :update, :destroy]

	def index
		@group = Group.find(params[:group_id])
		@messages = @group.messages.sort_by { |e| e.created_at }
	end

	# def new
	# 	@message = Message.new
	# end

	def create
		@message = Message.create(message_params)

		if @message.valid?
			redirect_to group_messages
		else
			flash[:errors] = @message.errors.full_messages
			redirect_to group_messages
		end
	end

	# def update
	# 	@message.update(message_params)

	# 	if @message.valid?
	# 		redirect_to @message
	# 	else
	# 		flash[:errors] = @message.errors.full_messages
	# 		redirect_to edit_message_path
	# 	end
	# end
	
	# def destroy
	# 	@message.destroy
	# 	redirect_to messages_path
	# end

	# def show
	# end

	# def edit
	# end

	private

	# def find_message
	# 	@message = Message.find(params[:id])
	# end

	def message_params
		params.require(:message).permit(:content, :user_id, :group_id)
	end
end

class MessagesController < ApplicationController
	def create
		# byebug
		@message = Message.create(message_params)
		redirect_to user_group_path(params[:message][:user_id], params[:message][:group_id])
	end

	private

	def message_params
		params.require(:message).permit(:content, :user_id, :group_id)		
	end
end

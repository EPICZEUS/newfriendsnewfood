class MessagesController < ApplicationController
	def create
		@message = Message.create(message_params)
		redirect_to [@message.user, @message.group]
	end

	private

	def message_params
		params.require(:message).permit(:content, :user_id, :group_id)		
	end
end

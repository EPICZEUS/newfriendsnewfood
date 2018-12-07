class GroupSearchesController < ApplicationController
	def index
		@searches = GroupSearch.where(user_id: params[:user_id]).select { |e| !e.user.groups.any? { |g| g.potential_restaurants.include?(e.restaurant) } }
	end

	def create
		@search = GroupSearch.new(group_search_params)

		group = Group.all.find { |e| e.users.include?(current_user) && (e.potential_restaurants.include?(@search.restaurant) || e.restaurants.include?(@search.restaurant))}

		if group
			redirect_to [current_user, group]
		else
			@search.save
			redirect_to [current_user, @search]
		end
	end

	def show
		@group_search = GroupSearch.find(params[:id])
	end

	private

	def group_search_params
		params.require(:group_search).permit(:user_id, :restaurant_id)
	end
end

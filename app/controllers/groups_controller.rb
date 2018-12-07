class GroupsController < ApplicationController
  before_action :find_group, only: [:show, :edit, :update, :destroy, :leave]

  def index
    @groups = Group.all.select { |e| e.users.include?(current_user) }
  end

  def show
    unless @group.users.include?(current_user)
      redirect_to user_groups_path(current_user)
    end
  end

  def create
    # byebug
    @group = Group.create(group_params)

    if @group.valid?
      redirect_to [current_user, @group]
    else
      flash[:errors] = @group.errors.full_messages
      redirect_to user_groups_path(current_user)
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      if params[:commit] == "Leave"
        @group.destroy unless group_params[:user_ids]
        redirect_to current_user
      else
        redirect_to [current_user, @group]
      end
    else
      flash[:errors] = @group.errors.full_messages
      redirect_to edit_group_path
    end
  end

  def destroy
    @group.destroy
    redirect_to user_groups_path(current_user)
  end

  private

  def find_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, user_ids:[])
  end
end

class GroupsController < ApplicationController
  before_action :find_group, only: [:show, :edit, :update, :destroy]
  before_action :find_user, only: [:index, :show]

  def index
    @groups = Group.all.select { |e| e.users.include?(@user) }
  end

  def show
  end

  def create
    # byebug
    @group = Group.create(group_params)

    if @group.valid?
      redirect_to user_group_path(@current_user, @group)
    else
      flash[:errors] = @group.errors.full_messages
      redirect_to user_groups_path(@current_user)
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to @group
    else
      flash[:errors] = @group.errors.full_messages
      redirect_to edit_group_path
    end
  end

  def destroy
    @group.destroy
    redirect_to user_groups_path(@current_user)
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, user_ids:[])
  end
end

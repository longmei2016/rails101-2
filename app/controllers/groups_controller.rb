class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy ]
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy ]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.rencent
  end
  # show action,表单位于app/views/groups/show.html.erb

  def edit
  end

  def new
    @group = Group.new
  end
# new action
# new action 的表单 位于 app/views/groups/new.html.erb

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end
  # create action:  接收 new 里的表单送出的讯息，变成一笔存在资料库里的资料

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: "Update Success"
    else
      render :edit
    end
  end
  # update action:  接收 edit 里的表单送出的讯息，真正更新存在资料库里的资料。

  def destroy
    @group.destroy
    flash[:alert] = "Group deleted"
      redirect_to groups_path
  end

  private

  def find_group_and_check_permission
    @group = Group.find(params[:id])
    if current_user != @group.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

  def group_params
    params.require(:group).permit(:title, :description)
  end

end

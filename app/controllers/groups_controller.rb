class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end
  # show action,表单位于app/views/groups/show.html.erb

  def edit
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end
# new action
# new action 的表单 位于 app/views/groups/new.html.erb

  def create
    @group = Group.new(group_params)
    @group.save
      redirect_to groups_path
  end
  # create action:  接收 new 里的表单送出的讯息，变成一笔存在资料库里的资料

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
      redirect_to groups_path, notice: "Update Success"
  end
  # update action:  接收 edit 里的表单送出的讯息，真正更新存在资料库里的资料。

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end

end

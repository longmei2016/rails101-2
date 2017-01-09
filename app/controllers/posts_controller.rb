class PostsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)

    else
      render :new
    end
  end

  private



  def post_params
    params.require(:post).permit(:content)
  end
end

=begin
def edit
    @group = Post.find(params[:id])
  end

  def update
    if @post.update(post_params)
      redirect_to groups_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def delete
    @post.delete(post_params)
    flash[:alert] = "Post deleted"
      redirect_to groups_path(@group)
  end

  def destroy
    @post.delete(post_params)
    flash[:alert] = "Post deleted"
      redirect_to groups_path(@group)
  end
=end

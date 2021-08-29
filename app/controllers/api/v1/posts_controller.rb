# Inherits from the API base controller
class Api::V1::PostsController < Api::V1::BaseController
  def index
    # classic Pundit syntax for index. Replaces Post.all
    @posts = policy_scope(Post)
  end

  def show
    @post = Post.find(params[:id])
    authorize @post # links to pundit's policy
  end
end

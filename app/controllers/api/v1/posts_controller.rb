# Inherits from the API base controller
class Api::V1::PostsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]

  def index
    # classic Pundit syntax for index. Replaces Post.all
    @posts = policy_scope(Post)
  end

  def show
    @post = Post.find(params[:id])
    authorize @post # links to pundit's policy
  end

  def update
    @post = Post.find(params[:id])
    authorize @post # links to pundit's policy
    if @post.update(post_strong_params)
      render :show
    else
      render_error
    end
  end

  def create
    @post = Post.new(post_strong_params)
    authorize @post
    @post.user = current_user
    if @post.save
      render :show, status: :created # status is optional. turns 200 into 201
    else
      render_error
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post
    if @post.destroy
      @posts = policy_scope(Post)
      render :index
    else
      render_error
    end
  end

  private

  def post_strong_params
    params.require(:post).permit(:title, :content)
  end

  def render_error
    render json: { errors: @post.errors.full_messages },
      status: :unprocessable_entity
  end

end

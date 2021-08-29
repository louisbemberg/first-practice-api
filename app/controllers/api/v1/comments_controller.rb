# Inherits from the API base controller
class Api::V1::CommentsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User

  def create
    # /api/v1/posts/:post_id/comments
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_strong_params)
    @comment.user = current_user
    @comment.post = @post
    authorize @comment
    if @comment.save
      render 'api/v1/posts/show' # redirects to the post that used to have that comment
    else
      render_error
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    if @comment.destroy
      @post = @comment.post
      render 'api/v1/posts/show'
    else
      render_error
    end
  end

  private

  def comment_strong_params
    params.require(:comment).permit(:content)
  end

  def render_error
    render json: { errors: @comment.errors.full_messages },
      status: :unprocessable_entity
  end
end

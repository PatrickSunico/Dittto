class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user

  def create
    # 1. find the post first
    @post = Post.friendly.find(params[:post_id])
    # 2. create the comment with the comment_params
    @comment = Comment.create(comment_params)
    # 3. Define which user added the comment
    @comment.user_id = current_user.id
    # 4. Define which post the comment was associated to.
    @comment.post_id = @post.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
        # format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        # format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # Find existing post
    @post = Post.find(params[:id])
    # find the comment to delete
    @comment = Comment.find(params[:post_id])
      if @comment.destroy
       respond_to do |format|
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully Deleted.' }
        format.json { head :no_content}
      end
    end
  end

  private
    def find_post_comment
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end

    def authorize_user
      if current_user.nil?
        redirect_to new_user_session_path, alert: "Not Authorized Please Login"
      else
        if @post && @post.user != current_user
          redirect_to root_path
        end
      end
    end
end

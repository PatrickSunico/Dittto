
class AttachmentsController < ApplicationController
  before_action :set_upload, :only => [:new, :create ,:destroy]
  before_action :authorize_user, except: [:index, :show]
  def new
    # @post = Post.friendly.find(params[:post_id])
    @attachment = @post.attachments.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    # @post = Post.friendly.find(params[:post_id])
    @attachment = @post.attachments.create(attachment_params)

    respond_to do |format|
      if @attachment.save
        format.html { redirect_to(@post, notice: "Upload Successful")}
        format.json { render json: { message: "Success", fileID: @attachment.id, post: @post.id}, :status => 200 }
      else
        format.html { render :new }
        format.json { render json: {error: @attachment.errors.full_messages.join(',')}, :status => 400}
      end
    end
  end

  def destroy
    @attachment = @post.attachments.find(params[:id])
    respond_to do |format|
      if @attachment.destroy
        format.html {redirect_to post_path(@post), notice: "Attachment was Sucessfully destroyed"}
        format.json { head :no_content }
      end
    end
  end

  private
    def set_upload
      @post = Post.friendly.find(params[:post_id])
    end

    def attachment_params
      params.require(:attachment).permit(:image)
    end

    def authorize_user
      post = Post.friendly.find(params[:post_id])
      # user = User.where(post_id: post)
      attachment = Attachment.find_by_id(params[:post_id])

      if current_user.nil?
        redirect_to new_user_session_path
      else
        if post && post.user != current_user
          if post.user != attachment
            redirect_to root_path
          end
        end
      end
    end
end

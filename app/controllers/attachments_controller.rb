
class AttachmentsController < ApplicationController
  before_action :set_upload, :only => [:update, :destroy]
  before_action :authorize_user, except: [:index, :show]
  def new
    post = Post.find(params[:post_id])
    @attachment = post.attachments.build
    respond_to do |format|
      format.html
    end
  end

  def create
    @post = Post.find(params[:post_id])
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

  def edit
    post = Post.find(params[:id])
    @attachment = Attachment.find(params[:post_id])
  end

  def update
    respond_to do |format|
      if @attachment.update(attachment_params)
        format.html { redirect_to post_path(@post), notice: "Attachment was Successfully updated"}
        format.json { render json: { message: "success", fileID: @attachment.id}, :status => 200}
      else
        format.html {render :edit}
        format.json { render json: { error: @attachment.error.full_message.join(',')}, :status => 400}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @attachment.destroy
        format.html {redirect_to post_path(@post), notice: "Attachment was Sucessfully destroyed"}
        format.json { head :no_content }
      end
    end
  end

  private
    def set_upload
      @post = Post.find(params[:post_id])
      @attachment = @post.attachments.find(params[:id])
    end

    def attachment_params
      params.require(:attachment).permit(:image)
    end

    def authorize_user
      user = User.find_by_id(params[:user_id])
      post = Post.find_by_id(params[:post_id])
      attachment = Attachment.find_by_id(params[:post_id])


      if current_user.nil?
        redirect_to new_user_session_path
      else
        # if post.user_id != current_user.id
        #   # if post.id != attachment.post_id
        #     redirect_to root_path
        #   # end
        # end
        # @post && @post.user != current_user
        if post && post.user != current_user
          if post.user != attachment
            # Or make it as a route
            render "shared/error"
          end
        end

      end
    end
end

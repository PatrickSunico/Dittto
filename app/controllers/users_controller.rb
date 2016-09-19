class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    @user_posts = @user.posts.all
  end
end

class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @user = user.image
    @nickname = user.nickname
    @tweets = user.tweets
  end
end

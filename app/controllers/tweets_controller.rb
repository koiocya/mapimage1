class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_tweet, only: [:edit, :update, :destroy, :show]
  
  def index
    @tweets = Tweet.includes(:user).order(created_at: :DESC)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    if user_signed_in? && @tweet.user == current_user
      @tweet.destroy
      redirect_to root_path
    elsif @tweet.user != current_user
      redirect_to root_path
    end
  end

  def edit 
    if current_user == @tweet.user
      render :edit
    elsif current_user != @tweet.user
      redirect_to root_path
    else
      redirect_to user_sessions_path
    end
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweet_path
    else
      render :edit
    end
  end

  def show
  end


  private 

  def tweet_params
    params.require(:tweet).permit(:image, :title, :explain, :category_id, :prefecture_id, :city, :house_number).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end

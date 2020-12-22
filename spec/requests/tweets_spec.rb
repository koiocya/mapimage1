require 'rails_helper'

describe TweetsController, type: :request do

  before do
    @user = FactoryBot.create(:user)
 
    # @post = FactoryBot.create(:post, image: fixture_file_upload('public/images/test_image.png'))
    @tweet = FactoryBot.create(:tweet)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get root_path
      expect(response.status).to eq 200
    end
    it "indexアクションにリクエストするとレスポンスに投稿済みのツイートが存在する" do 
      get root_path
      expect(response.body).to include 'image'
      expect(response.body).to include @tweet.title
      expect(response.body).to include @tweet.prefecture.name
      expect(response.body).to include @tweet.user.nickname
    end
  end

  describe "GET #new" do
    it 'ログインしていないユーザーがnewアクションをするとリダイレクトされる' do
      get new_tweet_path
      expect(response.status).to eq 302
    end
    it "newアクションにリクエストすると正常にレスポンスが返ってくる" do
      sign_in @user
      get new_tweet_path
      expect(response.status).to eq 200
    end
    it 'ログインしたユーザーがnewアクションをするとレスポンスに投稿画面が存在する' do
      sign_in @user
      get new_tweet_path
      expect(response.body).to include "投稿画像を選択"
      expect(response.body).to include "tweets-title"
      expect(response.body).to include "tweets-category"
      expect(response.body).to include "tweets-prefecture"
      expect(response.body).to include "tweets-city"
      expect(response.body).to include "tweets-house_number"
      expect(response.body).to include "投稿"
    end
  end

  describe "POST #create" do
    it 'ログインしていないユーザーがcreateアクションをするとリダイレクトされる' do
      post tweets_path
      expect(response.status).to eq 302
    end
  end

  describe "GET #edit" do
    it 'ログインしていないユーザーがcreateアクションをするとリダイレクトされる' do
      get edit_tweet_path(@tweet)
      expect(response.status).to eq 302
    end
  end

  describe "PUT #update" do
    it 'ログインしていないユーザーがcreateアクションをするとリダイレクトされる' do
      put tweet_path(@tweet)
      expect(response.status).to eq 302
    end
  end

  describe "DELETE #destory" do
    it 'ログインしていないユーザーがcreateアクションをするとリダイレクトされる' do
      delete tweet_path(@tweet)
      expect(response.status).to eq 302
    end
  end

  describe "GET #show" do
    it "showアクションにリクエストすると正常にレスポンスが返ってくる" do
      get tweet_path(@tweet)
      expect(response.status).to eq 200
    end
    it "showアクションにリクエストするとレスポンスに投稿済みのツイートが存在する" do 
      get tweet_path(@tweet)
      expect(response.body).to include 'image'
      expect(response.body).to include @tweet.title
      expect(response.body).to include @tweet.explain
      expect(response.body).to include @tweet.category.name
      expect(response.body).to include @tweet.prefecture.name
      expect(response.body).to include @tweet.city
      expect(response.body).to include @tweet.house_number
    end
    it "showアクションにリクエストするとレスポンスにコメント一覧表示部分が存在する" do 
      get tweet_path(@tweet)
      expect(response.body).to include "＜コメント一覧＞"
    end
  end

  describe "GET #atlas" do
    it "ログインしていないユーザーがatlasアクションにリクエストするとリダイレクトされる" do
      get atlas_tweet_path(@tweet)
      expect(response.status).to eq 302
    end
    it'ログインしているユーザーであれば詳細ページからGoogleMapが存在するページに遷移できる' do
      get tweet_path(@tweet)
      get atlas_tweet_path(@tweet)
      expect(response.status).to eq 200
    end
  end

  describe "GET #seek" do
    it "ログインしていないユーザーがseekアクションにリクエストするとリダイレクトされる" do
      get seek_tweet_path(@tweet)
      expect(response.status).to eq 302
    end
    it'ログインしているユーザーであれば詳細ページからGoogleMapが存在するページに遷移できる' do
      get tweet_path(@tweet)
      get seek_tweet_path(@tweet)
      expect(response.status).to eq 200
    end
  end

end

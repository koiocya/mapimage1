require 'rails_helper'

describe TweetsController, type: :request do

  before do
    @tweet = FactoryBot.create(:tweet)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get root_path
      expect(response.status).to eq 200
    end
    it "indexアクションにリクエストするとレスポンスに投稿済みのツイートが存在する" do 
      get root_path
      image_path = Rails.root.join('spec/fixtures/test.jpg')
      expect(response.body).to include @tweet.title
      expect(response.body).to include @tweet.prefecture.name
      expect(response.body).to include @tweet.user.nickname
    end
  end
end

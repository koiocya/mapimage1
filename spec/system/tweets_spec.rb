require 'rails_helper'

RSpec.describe "Tweets", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet = FactoryBot.build(:tweet)
  end
  context 'ツイート投稿ができるとき' do
    it 'ログインしたユーザーは新規登録ができる' do
      #ログインする
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="signin"]').click
      #新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      #投稿ページに移動する
      visit new_tweet_path
      #フォームに情報を入力する
      image_path = Rails.root.join('spec/fixtures/test.jpg')
      attach_file('tweet[image]', image_path, make_visible: true)
      fill_in 'tweet_title', with: @tweet.title
      fill_in 'tweet[explain]', with:@tweet.explain
      find("#tweet-category").find("option[value='2']").select_option
      find("#tweet-prefecture").find("option[value='2']").select_option
      fill_in 'tweet[city]', with: @tweet.city
      fill_in 'tweet[house_number]', with: @tweet.house_number
      #投稿するとTweetモデルのカウントが１上がることを確認する
      expect{
        find('input[name="tweetpost"]').click
      }.to change { Tweet.count }.by(1)
      #投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq root_path
      #投稿した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector("img")
    end
  end
  context 'ツイートが投稿できないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      #トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('投稿する')
    end
    it 'ログインしても誤った情報では投稿できない' do
      #ログインする
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="signin"]').click
      #新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      #投稿ページに移動する
      visit new_tweet_path
      #フォームに情報を入力する
      image_path = Rails.root.join("")
      attach_file('tweet[image]', image_path, make_visible: true)
      fill_in 'tweet_title', with: ""
      fill_in 'tweet[explain]', with: ""
      find("#tweet-category").find("option[value='1']").select_option
      find("#tweet-prefecture").find("option[value='1']").select_option
      fill_in 'tweet[city]', with: ""
      fill_in 'tweet[house_number]', with: ""
      #投稿ページに戻されることを確認する
      expect(current_path).to eq new_tweet_path
    end
  end
end

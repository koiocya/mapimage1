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
RSpec.describe 'ツイート編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context 'ツイートが編集できるとき' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      #ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @tweet1.user.email
      fill_in 'パスワード', with: @tweet1.user.password
      find('input[name="signin"]').click
      expect(current_path).to eq root_path
      #詳細ページへ移動する
      visit tweet_path(@tweet1)
      #ハンバーガーメニューをクリックする
      find('.btn-gnavi').click
      #編集ボタンがあることを確認する
      expect(page).to have_content('編集')
      #編集ページに遷移することを確認する
      visit edit_tweet_path(@tweet1)
      #既に投稿済みの内容がフォームに入っていることを確認する
      expect(page).to have_content('image')
      expect(find('#tweet_title').value).to eq @tweet1.title
      expect(find('#tweet_explain').value).to eq @tweet1.explain
      expect(page).to have_select('tweet-category', selected: '風景')
      expect(page).to have_select('tweet-prefecture', selected: '北海道')
      expect(find('#tweet_city').value).to eq @tweet1.city
      expect(find('#tweet_house_number').value).to eq @tweet1.house_number
      #投稿内容を編集する
      image_path = Rails.root.join('spec/fixtures/test.jpg')
      attach_file('tweet[image]', image_path, make_visible: true)
      fill_in 'tweet_title',with: "#{@tweet1.title}+編集したタイトル"
      fill_in 'tweet[explain]', with: "#{@tweet1.explain}+編集した詳細"
      find("#tweet-category").find("option[value='3']").select_option
      find("#tweet-prefecture").find("option[value='3']").select_option
      fill_in 'tweet[city]', with: "#{@tweet1.city}+編集した市町村"
      fill_in 'tweet[house_number]', with: "#{@tweet1.house_number}+編集した番地"
      #編集してもTweetモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="tweetedit"]').click
      }.to change { Tweet.count }.by(0)
       # 詳細画面に遷移したことを確認する
       expect(current_path).to eq tweet_path(@tweet1.id)
       #詳細ページには先ほど変更した内容の投稿が存在することを確認する（画像）
       expect(page).to have_content("image")
       #詳細ページには先ほど変更した内容の投稿が存在することを確認する（画像）
       expect(page).to have_content("#{@tweet1.title}+編集したタイトル")
       expect(page).to have_content("#{@tweet1.explain}+編集した詳細")
       expect(page).to have_content('野生動物')
       expect(page).to have_content('青森県')
       expect(page).to have_content("#{@tweet1.city}+編集した市町村")
       expect(page).to have_content("#{@tweet1.house_number}+編集した番地")
    end
  end
  context 'ツイート編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @tweet1.user.email
      fill_in 'パスワード', with: @tweet1.user.password
      find('input[name="signin"]').click
      expect(current_path).to eq root_path
      #詳細ページへ移動する
      visit tweet_path(@tweet2)
      # ツイート2に「ハンバーガーメニュー」ボタンがないことを確認する
      expect(page).to have_no_content('btn-gnavi')
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # ツイート1の詳細ページに遷移する
      visit tweet_path(@tweet1)
      # ツイート1に「ハンバーガーメニュー」ボタンがないことを確認する
      expect(page).to have_no_content('btn-gnavi')
      # ツイート2の詳細ページに遷移する
      visit tweet_path(@tweet2)
      # ツイート2に「ハンバーガーメニュー」ボタンがないことを確認する
      expect(page).to have_no_content('btn-gnavi')
    end
  end
end
RSpec.describe 'ツイート削除', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context 'ツイートが削除できるとき' do
    it 'ログインしたユーザーは自ら投稿したツイートの削除ができる' do
      #ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @tweet1.user.email
      fill_in 'パスワード', with: @tweet1.user.password
      find('input[name="signin"]').click
      expect(current_path).to eq root_path
      #詳細ページへ移動する
      visit tweet_path(@tweet1)
      #ハンバーガーメニューをクリックする
      find('.btn-gnavi').click
      #削除ボタンがあることを確認する
      expect(page).to have_content('削除')
      #投稿を削除するとレコードの数が１減ることを確認する
      expect{click_on '削除'}.to change {Tweet.count}.by(-1)
      #トップページに遷移する
      visit root_path
      #トップページにはツイート1の内容が存在しないことを確認する
      expect(page).to have_no_content('@tweet1.image')
      expect(page).to have_no_content('@tweet1.title')
      expect(page).to have_no_content('@tweet1.prefecture')
      expect(page).to have_no_content('@tweet1.title')
    end
  end
  context 'ツイートを削除でいないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの削除画面には遷移できない' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @tweet1.user.email
      fill_in 'パスワード', with: @tweet1.user.password
      find('input[name="signin"]').click
      expect(current_path).to eq root_path
      #詳細ページへ移動する
      visit tweet_path(@tweet2)
      # ツイート2に「ハンバーガーメニュー」ボタンがないことを確認する
      expect(page).to have_no_content('btn-gnavi')
    end
    it 'ログインしていないとツイートの削除画面には遷移できない' do
      # トップページにいる
      visit root_path
      # ツイート1の詳細ページに遷移する
      visit tweet_path(@tweet1)
      # ツイート1に「ハンバーガーメニュー」ボタンがないことを確認する
      expect(page).to have_no_content('btn-gnavi')
      # ツイート2の詳細ページに遷移する
      visit tweet_path(@tweet2)
      # ツイート2に「ハンバーガーメニュー」ボタンがないことを確認する
      expect(page).to have_no_content('btn-gnavi')
    end
  end
end

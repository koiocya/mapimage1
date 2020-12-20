require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @tweet = FactoryBot.create(:tweet)
    @comment = Faker::Lorem.sentence
  end
  it 'ログインしたユーザーはツイート詳細ページでコメント投稿できる' do
    #ログインする
    visit new_user_session_path
    fill_in 'メールアドレス', with: @tweet.user.email
    fill_in 'パスワード', with: @tweet.user.password
    find('input[name="signin"]').click
    expect(current_path).to eq root_path
    #ツイート詳細ページに遷移する
    visit tweet_path(@tweet)
    #フォームに情報を入力する
    fill_in 'comment_text', with: @comment
    #コメントを送信すると、Commentモデルのカウントが１上がることを確認する
    expect{
      find('input[name="commentpost"]').click
    }.to change { Comment.count }.by(1)
    #詳細ページにリダイレクト
    expect(current_path).to eq tweet_path(@tweet)
    #詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content @comment
  end
end

RSpec.describe'コメント削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet = FactoryBot.create(:tweet)
    @comment1 = FactoryBot.create(:comment)
  end
  context 'コメントを削除できるとき' do
    it 'ログインしたユーザーは自分のコメントを削除できる' do
      #ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @tweet.user.email
      fill_in 'パスワード', with: @tweet.user.password
      find('input[name="signin"]').click
      expect(current_path).to eq root_path
      #ツイート詳細ページに遷移する
      visit tweet_path(@tweet)
      #フォームに情報を入力する
      fill_in 'comment_text', with: @comment1
      #コメントを送信すると、Commentモデルのカウントが１上がることを確認する
      expect{
        find('input[name="commentpost"]').click
      }.to change { Comment.count }.by(1)
      #詳細ページにリダイレクト
      expect(current_path).to eq tweet_path(@tweet)
      #詳細ページ上に先ほどのコメント内容が含まれていることを確認する
      expect(page).to have_content @comment1
      #削除ボタンがあることを確認する
      expect(page).to have_content('コメント削除')
      #コメントを削除すると、Commentモデルのカウントが１減ることを確認する
      expect{click_on'コメント削除'}.to change {Comment.count}.by(-1)
      #ツイート詳細ページに遷移する
      visit tweet_path(@tweet)
      #ツイート詳細ページにはコメント1が存在しないことを確認する
      expect(page).to have_no_content('@comment1.text')
    end
  end
  context 'コメントが削除できないとき' do
    it 'ログインしたユーザーは自分以外のコメントは削除できない' do
      #コメント1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @comment1.user.email
      fill_in 'パスワード', with: @comment1.user.password
      find('input[name="signin"]').click
      expect(current_path).to eq root_path
      #ツイート詳細ページに遷移する
      visit tweet_path(@tweet)
      #フォームに情報を入力する
      fill_in 'comment_text', with: @comment1.text
      #コメントを送信する
      click_on '送信'
      #詳細ページにリダイレクト
      expect(current_path).to eq tweet_path(@tweet)
      #コメントを投稿したユーザーをログアウトする
      expect(page).to have_content('ログアウト')
      click_on 'ログアウト'
      #コメントしたユーザーとは違うユーザーでログインする
      expect(page).to have_content('ログイン')
      click_on 'ログイン'
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="signin"]').click
      expect(current_path).to eq root_path
      #詳細ページに遷移する
      visit tweet_path(@tweet)
      #コメント削除ボタンがないことを確認する
      expect(page). to have_no_content('コメント削除')
    end
    it 'ログインしたユーザーでないとコメントを削除できない' do
      #トップページにいることを確認する
      #コメント1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @comment1.user.email
      fill_in 'パスワード', with: @comment1.user.password
      find('input[name="signin"]').click
      expect(current_path).to eq root_path
      #ツイート詳細ページに遷移する
      visit tweet_path(@tweet)
      #フォームに情報を入力する
      fill_in 'comment_text', with: @comment1.text
      #コメントを送信する
      click_on '送信'
      #詳細ページにリダイレクト
      expect(current_path).to eq tweet_path(@tweet)
      #コメントを投稿したユーザーをログアウトする
      expect(page).to have_content('ログアウト')
      click_on 'ログアウト'
      #ツイート詳細ページに遷移する
      visit tweet_path(@tweet)
      #コメント削除ボタンがないことを確認する
      expect(page). to have_no_content('コメント削除')
    end
  end
end

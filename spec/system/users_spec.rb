require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザーが新規登録ができるとき' do
    it '正しい情報を入力すればユーザーが新規登録ができてトップページに移動する' do
      #トップページに移動する
      visit root_path
      #トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      #新規登録ページへ移動する
      visit new_user_registration_path
      #ユーザー情報を入力する
      image_path = Rails.root.join('spec/fixtures/test.jpg')
      attach_file('user[image]', image_path, make_visible: true)
      fill_in 'ニックネーム', with: @user.nickname
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      fill_in 'パスワード(確認)', with: @user.password_confirmation
      #登録ボタンを押すとユーザーモデルにカウントが１上がることを確認する
      expect{
        find('input[name="signup"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # トップページにログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザーが新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページに戻ってくる' do
      #トップページに移動する
      visit root_path
      #トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      #新規登録ページへ移動する
      visit new_user_registration_path
      #ユーザー情報を入力する
      image_path = Rails.root.join("")
      attach_file('user[image]', image_path, make_visible: true)
      fill_in 'ニックネーム', with: ""
      fill_in 'メールアドレス', with: ""
      fill_in 'パスワード', with: ""
      fill_in 'パスワード(確認)', with: ""
      #登録ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="signup"]').click
      }.to change {User.count }.by(0)
      #新規登録ページに戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end

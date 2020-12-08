require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録ができる時' do
      it "nicknameとemailとpasswordとpassword_confirmationが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "introductionが空でも登録できる" do
       @user.introduction = nil
       expect(@user).to be_valid
      end
      it "passwordが8文字以上であれば登録できる" do
        @user.password = "a1234567"
        expect(@user).to be_valid
      end
      it "passwordが英数字混合で8文字以上であれば登録できる" do
        @user.password = "a1234567"
        expect(@user).to be_valid
      end
    end

    context '新規登録ができない時' do
      it "nicknameが空であるとき" do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it "emailが空であるとき" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it "emailに@がないとき" do
        @user.email = "test.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it "passwordが空であるとき" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワード半角英数字で入力して下さい", "パスワードを入力してください", "パスワードは8文字以上で入力してください", "パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordがパスワードは、8文字以上での入力でないと登録できない' do
        @user.password = 'a123456'
        @user.password_confirmation = 'a123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは8文字以上で入力してください')
      end
      it 'パスワードは、確認用を含めて2回入力すること' do
        @user.password = 'a1234567'
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'パスワードとパスワード（確認用）、値の一致しないと登録できない' do
        @user.password = 'a1234567'
        @user.password_confirmation = 'b1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'password:半角英数混合(半角英語のみ)' do
        @user.password = 'aaaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード半角英数字で入力して下さい')
      end
    end
  end
end

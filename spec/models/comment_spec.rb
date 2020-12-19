require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = FactoryBot.build(:user)
    @tweet = FactoryBot.build(:tweet)
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメントの保存' do
    context 'コメントが保存できる場合' do
      it "テキストがあればコメントは保存される" do
        expect(@user).to be_valid
        expect(@tweet).to be_valid
        expect(@comment).to be_valid
      end
    end
    context 'コメントが保存できない場合' do
      it "テキストがないとコメントは保存されない" do
        @comment.text = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("テキストを入力してください")
      end
    end
  end
end

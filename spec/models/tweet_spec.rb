require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe '#create' do
    before do
      @tweet = FactoryBot.build(:tweet)
    end

    describe '新規投稿' do
      context '新規投稿ができる時' do
        it "title,explain,category,prefecture,city,house-number,imageが存在すれば登録できる" do
          expect(@tweet).to be_valid
        end
        it "番地が無くても登録ができる" do
          @tweet.house_number = nil
          expect(@tweet).to be_valid
        end
      end

      context '新規投稿ができない時' do
        it '画像がないと投稿できない' do
          @tweet.image = nil
          @tweet.valid?
          expect(@tweet.errors.full_messages).to include("画像選択してください")
        end
        it 'タイトルがないと投稿できない' do
          @tweet.title = nil
          @tweet.valid?
          expect(@tweet.errors.full_messages).to include("タイトルを入力してください")
        end
        it 'ポイントがないと投稿できない' do
          @tweet.explain = nil
          @tweet.valid?
          expect(@tweet.errors.full_messages).to include("ポイントを入力してください")
        end
        it 'カテゴリーの選択が１番だと投稿できない' do
          @tweet.category_id = "1"
          @tweet.valid?
          expect(@tweet.errors.full_messages).to include("カテゴリーを選択してください")
        end
        it '都道府県の選択が１番だと投稿できない' do
          @tweet.prefecture_id = nil
          @tweet.valid?
          expect(@tweet.errors.full_messages).to include("都道府県を選択してください")
        end
        it '市町村がないと投稿できない' do
          @tweet.city = nil
          @tweet.valid?
          expect(@tweet.errors.full_messages).to include("市町村を入力してください")
        end
      end
    end
  end
end

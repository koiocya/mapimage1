# README

# アプリケーションの概要
- ユーザー登録
- 画像投稿
- コメント記入
- 投稿した画像に緯度と経度の情報があればGoogleMapを使用して撮影地を指定することができる
- 投稿した画像からGoogleMapを使用して撮影地を指定することができる

# URL

# テスト用アカウント
- メールアドレス [test@test.com]
- パスワード    [a1234567]

# 利用方法
- ユーザー登録
 - 新規登録ボタンをクリックしユーザー情報入力画面に遷移する
 - 項目全てを記入する
 - トップページに遷移する
- 新規投稿
 - 投稿するボタンをクリックしユーザー情報入力画面に遷移する
 - 項目全てを記入する
 - 投稿ボタンを押す
 - トップページに遷移する
- 詳細ページ
 - 画像から検索
  - 投稿されてる画像をクリックし詳細ページに遷移する
  - 画像から検索ボタンをクリックする
  - 検索するボタンをクリックする
  - GoogleMapに撮影地が表示される
 - 住所から検索
  - 投稿されてる画像をクリックし詳細ページに遷移する
  - 住所から検索ボタンをクリックする
  - 検索するボタンをクリックする
  - GoogleMapに撮影地が表示される

# 目指した課題解決
- 投稿されている画像を見て自分も同じように撮影したいが、場所が分からず困っている課題を解決するために作成

# 洗い出した要件
- ユーザー機能
- 画像一覧表示機能
- 画像詳細表示機能
- 画像編集機能
- 画像削除機能
- コメント機能
- 画像とGoogleMap連携機能

# 実装した機能についてのGIFと説明
- 画像から検索機能
 - https://gyazo.com/2ae4679d7bacb533f831f03352ee1336
- 住所から検索機能
 - https://gyazo.com/d4206c0434894002bfc2f42c43f7a34e

# 実装予定の機能
- 現在地の表示機能
- 現在地から撮影地までのルート検索機能

# データベース設計
- https://gyazo.com/849bc41afcfcc46a37bf4ced7ded8522

# ローカルでの動作方法
- $ git clone https://github.com/koiocya/mapimage1.git
- 環境
 - ruby '2.6.5'
 - gem 'rails', '~> 6.0.0'
 - gem 'mysql2', '>= 0.4.4'
 - gem 'puma', '~> 3.11'
 - gem 'sass-rails', '~> 5'
 - gem 'webpacker', '~> 4.0'
 - gem 'turbolinks', '~> 5'
 - gem 'jbuilder', '~> 2.7'
 - gem 'rspec-rails', '~> 4.0.0'
 - gem 'capybara', '>= 2.15'

# テーブル設計

## users テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| nickname           | string  | null: false |
| email              | string  | null: false |
| encrypted_password | string  | null: false |
| introduction       | string  | null: false |

### Association

- has_many :tweets
- has_many :comments

## tweets テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- |------------------------------- |
| title             | string     | null: false                    |
| explain           | string     | null: false                    |
| category_id       | integer    | null: false                    |
| prefecture_id     | integer    | null: false                    |
| city              | string     | null: false                    |
| house_number      | string     | null: false                    |
| user              | references | null: false, foreign_key: true |


### Association
- has_one :comments
- belongs_to :user

## comments テーブル

| Column    | Type       | Options        |
| --------- | ---------- | -------------- |
| text      | text       | null: false    |
| user      | integer    | null: false,   |
| tweet     | integer    | null: false,   |

### Association

- belongs_to :user
- belongs_to :tweet


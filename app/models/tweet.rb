class Tweet < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :prefecture

  validates :image, presence: {message:'選択してください'}
  validates :title, :explain, :city, :house_number, presence: true
  validates :category_id, :prefecture_id, numericality: {other_than: 1, message:'を選択してください' }

  
end

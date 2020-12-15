class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #以下：ユーザー編集機能
  
  def update_without_current_password(params, *options)
     params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end


  #以下：ユーザー登録機能の制限
  validates :nickname, presence: true 
    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    validates_format_of :password, { with: PASSWORD_REGEX, message: '半角英数字で入力して下さい' }
    validates :password, presence: true, length: { minimum: 8 }

  #以下：ユーザー画像機能
  mount_uploader :image, ImageUploader
  validates :image, presence: { message: 'を選択してください' }


  #以下：アソシエーション
  has_many :tweets
  has_many :comments

end

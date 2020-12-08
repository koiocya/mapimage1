class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :title,  null: false
      t.string :explain,  null: false
      t.integer :category_id, null: false
      t.integer :prefecture_id, null: false
      t.string :city, null: false
      t.string :house_number, null: false
      t.references :user, foreign_key: true
      # t.references :comment, foreign_key: true
      t.timestamps
    end
  end
end

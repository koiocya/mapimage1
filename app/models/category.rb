class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '風景' },
    { id: 3, name: '野生動物' },
    { id: 4, name: 'マクロ' },
    { id: 5, name: '水中' },
    { id: 6, name: '天体' },
    { id: 7, name: '航空' },
    { id: 8, name: 'ポートレート' },
    { id: 9, name: 'ブライダル' },
    { id: 10, name: 'スポーツ' },
    { id: 11, name: 'ファッション' },
    { id: 12, name: 'ストリートスナップ' },
    { id: 13, name: 'イベント' },
    { id: 14, name: '旅行' },
    { id: 15, name: '都市風景' },
    { id: 16, name: '商品' },
    { id: 17, name: '料理' },
    { id: 18, name: '建築' },
    { id: 19, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :tweets

end

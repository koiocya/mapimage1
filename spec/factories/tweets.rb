FactoryBot.define do
  factory :tweet do
    association :user
    
    title          {"test"}
    explain        {"abcdefg"}
    category_id    {"2"}
    prefecture_id   {"2"}
    city           {'札幌市'}
    house_number   {'50'}

    after(:build) do |tweet|
      tweet.image.attach(io: File.open('public/images/test_image.png'),filename: 'test_image.png')
    end
  end
end

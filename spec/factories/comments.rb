FactoryBot.define do
  factory :comment do
    association :user
    association :tweet
     text    {"test"}
  end
end

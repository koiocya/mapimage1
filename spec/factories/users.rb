FactoryBot.define do
  factory :user do
    nickname      {"test"}
    introduction  {"abcdefg"}
    email         {"test@test.com"}
    password      {"a1234567"}
    password_confirmation {password}
  end
end

FactoryBot.define do
  factory :user do
    nickname      {"test"}
    image         { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
    introduction  {"abcdefg"}
    email         {"test@test.com"}
    password      {"a1234567"}
    password_confirmation {password}

    
  end
end

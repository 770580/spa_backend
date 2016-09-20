FactoryGirl.define do
  factory :user do
    name "MyString"
    password_digest "MyString"
  end
  factory :post do
    title "Hot news"
    body "Invasion"
    username "Kevin"
  end
end
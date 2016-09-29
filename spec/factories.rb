FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Hot news #{n}" }
    sequence(:body) { |n| "Invasion #{n}" }
    username "Kevin"
  end

  factory :user do
    name "test"
    password "123"
    password_confirmation "123"
  end
end

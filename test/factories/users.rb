FactoryBot.define do
  factory :user do
    email { 'ken@example.com' }
    password { 'ken_password' }
  end

  factory :other_user, class: User do
    email { 'taro@example.com' }
    password { 'taro_password' }
  end
end

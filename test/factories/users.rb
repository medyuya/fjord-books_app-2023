# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'ken@example.com' }
    password { 'ken_password' }
  end
end

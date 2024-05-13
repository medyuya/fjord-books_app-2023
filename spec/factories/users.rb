# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'ken' }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'passabcd1234' }
  end
end

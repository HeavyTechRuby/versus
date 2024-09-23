# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    sequence(:email) { |n| "email_#{n}@email.com" }
    password { 'qwerty123' }
    password_confirmation { 'qwerty123' }
    sequence(:username) { |n| "username#{n}" }
    sequence(:name) { |n| "name#{n}" }
  end
end

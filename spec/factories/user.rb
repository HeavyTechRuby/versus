# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    sequence(:email) { |n| "email_#{n}@email.com" }
    password { 'qwerty123' }
    password_confirmation { 'qwerty123' }
    username { Faker::FunnyName.name }
    name { Faker::Name.name }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'qwerty123' }
    password_confirmation { 'qwerty123' }
    username { Faker::FunnyName.name }
    name { Faker::Name.name }
  end
end

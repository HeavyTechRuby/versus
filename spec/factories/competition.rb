# frozen_string_literal: true

FactoryBot.define do
  factory :competition do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    association :author, factory: :user
  end
end

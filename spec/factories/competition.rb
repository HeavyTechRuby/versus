# frozen_string_literal: true

FactoryBot.define do
  factory :competition, class: Competition do
    sequence(:name) { |n| "Test Competition #{n}" }
    description { 'Some interesting description' }
    association :author, factory: :user
  end
end

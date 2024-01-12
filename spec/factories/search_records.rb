# frozen_string_literal: true

FactoryBot.define do
  factory :search_record do
    query { 'What is a good car' }
    association :user, factory: :user
  end
end

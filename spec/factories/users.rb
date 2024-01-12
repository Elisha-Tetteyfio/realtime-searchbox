# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    ip_address { '::1' }
  end
end

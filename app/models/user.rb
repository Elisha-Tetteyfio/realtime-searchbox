# frozen_string_literal: true

class User < ApplicationRecord
  validates :ip_address, presence: true
  has_many :search_records
end

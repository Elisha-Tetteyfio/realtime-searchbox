class User < ApplicationRecord
  validates :ip_address, presence: true
  has_many :search_records
end

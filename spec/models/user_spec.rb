# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'validates presence of ip_address' do
      user = create(:user)
      user.valid?
      expect(user).to be_valid
    end

    it 'validates presence of ip_address' do
      expect do
        create(:user, ip_address: nil)
      end.to raise_error(ActiveRecord::RecordInvalid, /Validation failed: Ip address can't be blank/)
    end
  end

  describe 'associations' do
    it 'has many search records' do
      expect(described_class.reflect_on_association(:search_records).macro).to eq :has_many
    end
  end
end

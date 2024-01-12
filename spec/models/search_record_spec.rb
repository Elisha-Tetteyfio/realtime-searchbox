# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchRecord, type: :model do
  describe 'validations' do
    it 'validates template search_record' do
      search_record = create(:search_record)
      search_record.valid?
      expect(search_record).to be_valid
    end

    it 'validates user for search_record' do
      expect do
        create(:search_record, user: nil)
      end.to raise_error(ActiveRecord::RecordInvalid, /Validation failed: User must exist/)
    end

    it 'validates query' do
      expect do
        create(:search_record, query: nil)
      end.to raise_error(ActiveRecord::RecordNotSaved, /Failed to save the record/)
    end
  end
end

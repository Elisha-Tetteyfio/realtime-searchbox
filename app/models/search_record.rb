# frozen_string_literal: true

class SearchRecord < ApplicationRecord
  belongs_to :user

  before_save :validate_query, :remove_extra_spaces
  after_save :delete_previous_substrings

  private

  # Delete extra spaces
  def remove_extra_spaces
    self.query = query.gsub(/\s+/, ' ').strip
  end

  def validate_query
    throw(:abort) if query_is_substring?(query)
    throw(:abort) if query.nil?
  end

  # Check if the query is a substring of something already in the database
  def query_is_substring?(query)
    existing_queries = user.search_records.where.not(id:).pluck(:query)
    existing_queries.any? { |existing_query| existing_query.downcase.include?(query.downcase) && existing_query.length > query.length}
  end
  
  #Delete all incomplete data
  def delete_previous_substrings
    existing_queries = user.search_records.where.not(id:).pluck('LOWER(query)')

    substrings_to_delete = existing_queries.select do |existing_query|
      query.downcase.include?(existing_query.downcase) && query.length > existing_query.length
    end

    user.search_records.where('LOWER(query) IN (?)', substrings_to_delete).destroy_all
  end
end

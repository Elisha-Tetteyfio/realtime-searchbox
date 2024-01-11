class SearchRecord < ApplicationRecord
  belongs_to :user

  before_save :remove_extra_spaces, :validate_query
  after_save :delete_previous_substrings

  private

  def remove_extra_spaces
    self.query = query.gsub(/\s+/, ' ').strip
  end

  def validate_query
    throw(:abort) if query_is_substring?(self.query)
  end

  def query_is_substring?(query)
    existing_queries = user.search_records.where.not(id: id).pluck(:query)
    existing_queries.any? { |existing_query| existing_query.downcase.include?(query.downcase) }
  end

  def delete_previous_substrings
    existing_queries = user.search_records.where.not(id: id).pluck("LOWER(query)")

    substrings_to_delete = existing_queries.select do |existing_query|
      self.query.downcase.include?(existing_query.downcase)
    end

    user.search_records.where("LOWER(query) IN (?)", substrings_to_delete).destroy_all
  end
end

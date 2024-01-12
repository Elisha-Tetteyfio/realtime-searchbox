# frozen_string_literal: true

class SearchRecordsController < ApplicationController
  before_action :set_user

  def index
    @search_records = SearchRecord.all
    @my_recent_searches = @user.search_records.all.order('created_at DESC').first(5)
  end

  def search
    query = params[:query]

    SearchRecord.create(query:, user: @user)

    render json: { status: 'success' }
  end

  def suggest
    suggestions = fetch_suggestions(params[:query])

    render json: suggestions
  end

  private

  def fetch_suggestions(query)
    existing_queries = @user.search_records.pluck(:query)

    related_searches = existing_queries.select do |existing_query|
      existing_query.downcase.include?(query.downcase)
    end
  end

  def set_user
    ip_address = request.remote_ip
    @user = User.find_or_create_by(ip_address:)
  end
end

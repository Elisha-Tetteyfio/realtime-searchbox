class SearchRecordsController < ApplicationController
  before_action :set_user

  def index
    @search_records = SearchRecord.all
    @my_recent_searches = @user.search_records.all.order("created_at DESC").first(5)
  end

  def search
    query = params[:query]
    
    SearchRecord.create(query: query, user: @user)

    render json: { status: 'success' }
  end

  private

  def set_user
    ip_address = request.remote_ip
    @user = User.find_or_create_by(ip_address: ip_address)
  end
end

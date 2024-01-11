class SearchRecordsController < ApplicationController
  def index
    @search_records = SearchRecord.all
  end

  def search
    query = params[:query]
    ip_address = request.remote_ip

    user = User.find_or_create_by(ip_address: ip_address)
    SearchRecord.create(query: query, user: user)

    render json: { status: 'success' }
  end
end

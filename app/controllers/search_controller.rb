class SearchController < BaseController
  
  def show
  end

  def search
	@results = PgSearch.multisearch(params[:query])
  end
end
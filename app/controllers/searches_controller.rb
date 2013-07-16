class SearchesController < ApplicationController
	def show
		@query = params[:query]
  	@results = Discussion.search_by_title(@query)
  end
end
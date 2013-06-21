class SearchesController < BaseController
  def new
    @search = Search.new(current_user)
  end

  def show
    puts params.inspect
    @search = Search.new(current_user)
    @search.submit(params[:search])
  end
end

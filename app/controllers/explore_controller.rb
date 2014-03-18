class ExploreController < ApplicationController
  def index
    # preload category, also motions..
    @groups = Group.categorised_any.preload(:category)
    @groups_by_category = @groups.group_by(&:category)
  end
end

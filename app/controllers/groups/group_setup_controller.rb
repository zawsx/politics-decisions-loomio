class Groups::GroupSetupController < GroupBaseController
  before_filter :authenticate_user!, except: [:selection, :subscription, :pwyc]
  
  def selection
  end

  # def pwyc
  #   @group_request = GroupRequest.new
  # end

  def subscription
    @group_request = GroupRequest.new
  end

end

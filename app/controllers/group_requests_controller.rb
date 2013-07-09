class GroupRequestsController < BaseController
  before_filter :authenticate_user!, except: [:create, :confirmation, :selection, :subscription]

  def create
    @group_request = GroupRequest.new(params[:group_request])
    if @group_request.save!
      @setup_group = SetupGroup.new(@group_request).approve_group_request
      redirect_to group_request_confirmation_url
    else
      render action: 'subscription'
    end
  end

  def confirmation
  end

  def selection
  end

  def subscription
    @group_request = GroupRequest.new
    @group_request.admin_name = current_user.name
    @group_request.admin_email = current_user.email
  end

end

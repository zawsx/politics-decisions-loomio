class Groups::MembershipRequestsController < BaseController
  before_filter :load_group, except: [:new, :cancel]
  before_filter :authenticate_user!, except: [:new, :create, :cancel]
  load_and_authorize_resource :membership_request, only: :cancel, parent: false


  def new
    @group = GroupDecorator.new Group.find(params[:group_id])
    @membership_request = MembershipRequest.new(group: @group)
    @membership_request.requestor = current_user
    render 'new'
  end

  def create
    build_membership_request
    if @membership_request.save
      flash[:success] = t('notice.membership_requested')
      Events::MembershipRequested.publish!(@membership_request)
      redirect_to @group
    else
      render 'new'
    end
  end

  def cancel
    @membership_request.destroy
    flash[:success] = t('notice.membership_request_canceled')
    redirect_to @membership_request.group
  end

  private

  def load_group
    @group ||= Group.find(params[:group_id])
  end

  def build_membership_request
    @membership_request = MembershipRequest.new params[:membership_request]
    @membership_request.group = @group
    @membership_request.requestor = current_user if user_signed_in?
  end
end

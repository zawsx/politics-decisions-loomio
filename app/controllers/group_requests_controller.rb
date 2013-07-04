class GroupRequestsController < BaseController
  before_filter :authenticate_user!, except: [:verify, :new, :create, :confirmation, 
    #mockups
    :sign_up_confirmation, :group_sign_up_which, :group_sign_up_formal, :group_sign_up_informal, :invitation_mailer, :trial_expiry_mailer, :trial_follow_up_mailer]
  before_filter :already_verified, only: :verify

  def new
    @group_request = GroupRequest.new
  end

  def create
    @group_request = GroupRequest.new(params[:group_request])
    if @group_request.save
      StartGroupMailer.verification(@group_request).deliver
      redirect_to group_request_confirmation_url
    else
      render action: 'new'
    end
  end

  def verify
    group_request.verify!
  end

  def confirmation
  end


# mockups actions
  def group_sign_up_which
    @group_request = GroupRequest.new
  end

  def group_sign_up_formal
    @group_request = GroupRequest.new
  end

  def group_sign_up_informal
    @group_request = GroupRequest.new
  end

  def invitation_mailer
    render "/start_group_mailer/invitation"
  end

  def trial_follow_up_mailer
    render "/start_group_mailer/trial_follow_up"
  end

  def trial_expiry_mailer
    render "/start_group_mailer/trial_expiry"
  end



  private

  def group_request
    return @group_request if @group_request
    @group_request = GroupRequest.find_by_token(params[:token])
  end

  def already_verified
    render 'application/display_error', locals: { message: t('error.group_request_already_verified') } if group_request.verified?
  end
end

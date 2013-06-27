class MembershipRequest < ActiveRecord::Base

  attr_accessible :name, :email, :introduction

  validates :name,  presence: true
  validates :email, presence: true, email: true #this uses the gem 'valid_email'

  validate :not_in_group_already
  validate :unique_membership_request
  # validates_presence_of :responder if 'response.present?'

  validates :group, presence: true

  belongs_to :group
  belongs_to :requestor, class_name: 'User'
  belongs_to :responder, class_name: 'User'

  delegate :admins,               to: :group, prefix: true
  delegate :members,              to: :group, prefix: true
  delegate :membership_requests,  to: :group, prefix: true
  delegate :members_invitable_by, to: :group, prefix: true

  def name
    if requestor.present?
      requestor.name
    else
      self[:name]
    end
  end

  def email
    if requestor.present?
      requestor.email
    else
      self[:email]
    end
  end

  def approved_by!(responder)
    set_response_details('approved', responder)
  end

  def ignored_by!(responder)
    set_response_details('ignored', responder)
  end

  private

  def set_response_details(response, responder)
    self.response = response
    self.responder = responder
    self.responded_at = Time.now
    save!
  end

  def not_in_group_already
    unless persisted?
      if group_members.find_by_email(email)
        errors.add(:email, I18n.t('error.user_with_email_address_already_in_group'))
      end
    end
  end

  def unique_membership_request
    unless persisted?
      if group_membership_requests.find_by_email(email)
        errors.add(:email, I18n.t('error.you_have_already_requested_membership'))
      end
    end
  end
end

class GroupRequest < ActiveRecord::Base

  attr_accessible :name, :admin_name, :admin_email

  validates :name, presence: true, length: {maximum: 250}
  validates :admin_name, presence: true, length: {maximum: 250}
  validates :admin_email, presence: true, email: true

  belongs_to :group

  scope :verified, where(status: :verified)
  scope :starred, where(high_touch: true)
  scope :not_starred, where(high_touch: false)
  scope :waiting, -> { verified.not_starred }
  scope :unverified, where(status: :unverified)
  scope :approved_but_not_setup, joins(:group).where("status = 'approved' AND groups.setup_completed_at IS NULL")
  scope :setup_completed, joins(:group).where('groups.setup_completed_at IS NOT NULL')
  scope :zero_members, joins(:group).where(groups: {memberships_count: 0}) 

  before_destroy :prevent_destroy_if_group_present
  before_create :mark_spam
  before_validation :generate_token, on: :create

  include AASM
  aasm column: :status do  # defaults to aasm_state
    state :unverified
    state :verified, initial: true
    state :approved
    state :defered
    state :manually_approved
    state :marked_as_spam

    event :verify do
      transitions to: :verified, from: [:unverified, :defered]
    end

    event :approve_request do
      transitions to: :approved, from: [:verified, :defered]
    end

    event :defer do
      transitions to: :defered, from: [:verified]
    end

    event :mark_as_manually_approved do
      transitions to: :manually_approved, from: [:unverified, :verified, :defered]
    end

    event :mark_as_spam do
      transitions to: :marked_as_spam, from: [:unverified, :verified, :defered]
    end

    event :mark_as_unverified do
      transitions to: :unverified, from: [:marked_as_spam, :manually_approved]
    end

  end

  def approve!
    update_attribute(:approved_at, DateTime.now)
    approve_request
    save!
  end

  def self.check_defered
    defered_requests = GroupRequest.where(status: 'defered')
    defered_requests.each do |group_request|
      group_request.verify! if group_request.defered_until < Time.now
    end
  end

  private
  def prevent_destroy_if_group_present
    if self.group.present?
      errors.add(:group, "dont' delete group requests ok!")
    end
    errors.blank?
  end

  def mark_spam
    mark_as_spam unless robot_trap.blank?
  end

  def generate_token
    begin
      token = SecureRandom.urlsafe_base64
    end while self.class.where(:token => token).exists?
    self.token = token
  end
end

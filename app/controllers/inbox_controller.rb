class InboxController < BaseController
  def index
    @inbox = Inbox.new(current_user).load
  end
end

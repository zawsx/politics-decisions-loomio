class InboxController < BaseController
  before_filter :load_inbox, only: [:index, :mark_as_read]

  def index
  end

  def preferences
    @inbox_preferences_form = InboxPreferencesForm.new(current_user)
  end

  def update_preferences
    @inbox_preferences_form = InboxPreferencesForm.new(current_user)
    @inbox_preferences_form.submit(params)
    redirect_to inbox_path
  end

  def mark_as_read
    @inbox.mark_as_read!(params[:class], params[:id])
    if request.xhr?
      head :ok
    else
      redirect_to inbox_path
    end
  end

  private
  def load_inbox
    @inbox = Inbox.new(current_user)
    @inbox.load
  end
end

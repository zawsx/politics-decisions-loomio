class InboxController < BaseController
  before_filter :load_inbox, only: [:index, :mark_as_read, :unfollow]

  def index
    if request.xhr?
      render layout: false
    end
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
    item = load_resource_from_params
    @inbox.mark_as_read!(item)

    if request.xhr?
      head :ok
    else
      redirect_to inbox_path
    end
  end

  def unfollow
    item = load_resource_from_params
    @inbox.unfollow!(item)

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

  def load_resource_from_params
    class_name = params[:class]
    id = params[:id]
    if class_name == 'Discussion'
      Discussion.find id
    end
  end

end

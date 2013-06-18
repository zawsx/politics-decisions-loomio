require 'spec_helper'

describe InboxController do
  before do
    sign_in FactoryGirl.create(:user)
  end

  context 'preferences' do
    it 'renders the preferences template' do
      get :preferences
      response.should render_template 'preferences'
    end
  end

  context 'put mark-as-read' do
    let(:inbox){stub(:inbox, load: true, mark_as_read!: true)}

    before do
      Inbox.should_receive(:new).and_return(inbox)
    end

    it 'marks the inbox item as read' do
      inbox.should_receive(:mark_as_read!).with('Discussion', "15")
      put :mark_as_read, class: 'Discussion', id: 15
    end

    it 'redirects_to /inbox' do
      put :mark_as_read, class: 'Discussion', id: 15
      response.should redirect_to inbox_path
    end
  end
end

require 'spec_helper'

describe InboxController do
  context 'preferences' do
    before do
      sign_in FactoryGirl.create(:user)
    end
    it 'renders the preferences template' do
      get :preferences
      response.should render_template 'preferences'
    end
  end

end

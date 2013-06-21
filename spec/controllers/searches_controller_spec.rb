require 'spec_helper'

describe SearchesController do

  let(:user) {FactoryGirl.create(:user)}
  before do
    sign_in user
  end
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    let(:search) {stub(:search)}
    it "returns http success" do
      Search.should_receive(:new).with(user).and_return(search)
      search.should_receive(:submit).with({'q' => 'term'})
      get 'show', search: {'q' => 'term'}
      assigns(:search).should == search
      response.should be_success
    end
  end

end

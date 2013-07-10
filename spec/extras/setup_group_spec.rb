require 'spec_helper'

describe SetupGroup do
  before do
    @approver = FactoryGirl.create(:user)
    @group_request = FactoryGirl.create(:group_request)
    @setup_group = SetupGroup.new(@group_request)
  end

  describe 'approve_group_request' do
    before do
      @group = @setup_group.approve_group_request
    end

    it 'creates the group' do
      @group.should be_persisted
    end

    it 'aprroves the group request' do
      @group_request.should be_approved
    end

    it 'assigns the group_request to the group' do
      @group.group_request.should == @group_request
    end
  end
end

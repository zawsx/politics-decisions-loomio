require 'spec_helper'

describe SearchesController do
	describe "#show" do
		# let(:results) { stub_model(Discussion, search_by_title: stub(:discussion))}
		before do
			controller.stub(:set_locale)
			# controller.stub_chain(:current_user, :discussions).and_return(results)
		end
		it "assigns a set of discussions that match the query item" do
			Discussion.should_receive(:search_by_title).with("Trees")
			get :show, query: "Trees"
		end
		it "renders the search page" do
			get :show, query: "Trees"
			response.should render_template 'show'
		end
	end
end

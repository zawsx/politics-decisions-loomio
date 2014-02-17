Given(/^I am subscribed to Loomio news$/) do
  @user.update_attribute(:subscribed_to_loomio_news, true)
end

Then(/^I should not be subscribed to the Loomio news email$/) do
  @user.reload
  @user.subscribed_to_loomio_news.should == false
end

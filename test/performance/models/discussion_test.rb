require 'performance_test_helper'
require 'factory_girl'
 
class DiscussionTest < ActionDispatch::PerformanceTest
  self.profile_options = { :runs => 5,
                           :metrics => [:wall_time, :process_time, :memory], :formats => [:call_stack]}

#  def test_creation
#    Discussion.create :body => 'still fooling you', :cost => '100'
#  end
# 
#  def test_slow_method
#    # Using posts(:awesome) fixture
#    posts(:awesome).slow_method
#  end
end

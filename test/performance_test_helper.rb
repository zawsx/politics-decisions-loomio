RAILS_ENV = "performance"
require File.expand_path('../../config/environment', __FILE__)
ActiveRecord::Base.establish_connection

require_dependency 'application_controller'
 
require 'test/unit'
require 'active_support/testing/performance'
require 'active_support/core_ext/kernel'
require 'active_support/test_case'
require 'action_controller/test_case'
require 'action_dispatch/testing/integration'
require 'rails/performance_test_help'

require "capybara/rails"
 
module ActionDispatch
  class PerformanceTest
    include Capybara::DSL
  end
end

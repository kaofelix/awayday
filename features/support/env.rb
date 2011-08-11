require 'capybara'
require 'capybara/cucumber'
require 'capybara/dsl'

World do
  include Capybara::DSL
  Capybara.app = AwayDayApp
end

require File.dirname(__FILE__) + '/../../awayday'


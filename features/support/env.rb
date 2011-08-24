require 'capybara'
require 'capybara/cucumber'
require 'capybara/dsl'
require 'rspec'

World do
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
  Capybara.app = AwayDayApp
  Mongoid.configure do |config|
    config.master = Mongo::Connection.new.db("test")
  end
end

After do |scenario|
  Presenter.destroy_all
  Talk.destroy_all
end

require File.dirname(__FILE__) + '/../../awayday'

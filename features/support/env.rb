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

Before do |scenario|
  Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
end

require File.join(File.dirname(__FILE__), '..', '..', 'awayday')

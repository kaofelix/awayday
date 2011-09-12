require File.join(File.dirname(__FILE__), '..', 'awayday')
require 'sinatra'
require 'rack/test'
require 'rspec'

include Rack::Test::Methods

class AwayDayApp < Sinatra::Base
  set :environment, :test

  Mongoid.configure do |config|
    config.master = Mongo::Connection.new.db("test")
  end
end

def app
  AwayDayApp
end

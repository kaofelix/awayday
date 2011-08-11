require 'sinatra/base'

class AwayDayApp < Sinatra::Base
  get '/' do
    haml :index
  end
end

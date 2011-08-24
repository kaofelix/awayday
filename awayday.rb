require 'sinatra/base'
require 'mongoid'

Dir["./models/**/*.rb"].each { |model| require model }

class AwayDayApp < Sinatra::Base
  get '/' do
    haml :index
  end

  post '/talk' do
    talk = Talk.new :title => params[:talk_title],
      :subject => params[:subject],
      :category => params[:category],
      :duration => params[:duration]
    talk.save

    redirect "/"
  end
end


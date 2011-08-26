require 'rack-flash'
require 'sinatra/base'
require 'sinatra/redirect_with_flash'
require 'mongoid'

Dir["./models/**/*.rb"].each { |model| require model }


class AwayDayApp < Sinatra::Base
  enable :sessions
  use Rack::Flash, :sweep => true

  get '/' do
    haml :index
  end

  post '/talk' do
    talk = Talk.new :title => params[:talk_title],
      :subject => params[:subject],
      :category => params[:category],
      :duration => params[:duration]
    talk.save

    redirect "/", flash[:notice] = "Congratulations"
  end

  get '/talks' do
    @talks = Talk.all

    haml :talks
  end

  get '/css/awayday.css' do
    scss :awayday
  end
end


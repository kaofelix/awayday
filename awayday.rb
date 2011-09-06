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

    presenter = Presenter.new :name => params[:name]

    presenter.talks << talk
    talk.save
    presenter.save

    redirect "/", flash[:notice] = create_success_message_for(presenter, talk)
  end

  get '/talks' do
    @talks = Talk.all

    haml :talks
  end

  get '/css/awayday.css' do
    scss :awayday
  end

  get '/images/background.png' do
    send_file './images/background.png'
  end

  private

  def create_success_message_for(presenter, talk)
    message = "Congratulations, #{presenter.name}. "
    message << "Your proposal '#{talk.title}' was submitted. "
    message << "You will have #{talk.duration}mins to present in the category #{talk.category}. "
  end
end


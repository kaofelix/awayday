require 'rack-flash'
require 'sinatra/base'
require 'sinatra/redirect_with_flash'
require 'sinatra/assetpack'
require 'mongoid'
require 'haml'

Dir["./models/**/*.rb"].each { |model| require model }

class AwayDayApp < Sinatra::Base
  set :root, File.dirname(__FILE__)
  register Sinatra::AssetPack

  enable :sessions
  use Rack::Flash, :sweep => true

  assets do
    serve '/css', from: '/assets/css'
    serve '/images', from: '/assets/images'
    serve '/fonts', from: '/assets/fonts'

    css :awayday, [ 'css/awayday.css' ]
    css_compression :sass
  end

  get '/' do
    @durations = Talk::DURATIONS
    @categories = Talk::CATEGORIES

    haml :index
  end

  post '/talk' do
    talk = Talk.new :title => params[:title],
      :summary => params[:summary],
      :category => params[:category],
      :duration => params[:duration]

    presenter = Presenter.new :name => params[:name], :email => params[:email]

    presenter.talks << talk
    talk.save
    presenter.save

    redirect "/", flash[:notice] = create_success_message_for(presenter, talk)
  end

  get '/talks' do
    @talks = Talk.all

    haml :talks
  end

  private

  def create_success_message_for(presenter, talk)
    message = "Congratulations #{presenter.name}. Your proposal was sent."
  end
end


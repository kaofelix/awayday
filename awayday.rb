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
    haml :form, :locals => {:durations => Talk::DURATIONS, :categories => Talk::CATEGORIES}
  end

  post '/talk' do
    talk = Talk.new :title => params[:title],
      :summary => params[:summary],
      :category => params[:category],
      :duration => params[:duration]

    presenter = Presenter.new :name => params[:name], :email => params[:email]
    presenter.talks << talk

    if talk.valid? and presenter.valid?
      presenter.save
      redirect "/", flash[:notice] = create_success_message_for(presenter)
    else
      session[:errors] = create_array_of_errors_for(presenter, talk)
      redirect "/", flash[:error] = create_error_message
    end
  end

  get '/talks' do
    haml :talks, :locals => {:talks => Talk.all}
  end

  private

  def create_success_message_for(presenter)
    "Congratulations #{presenter.name}. Your proposal was sent."
  end

  def create_error_message
    "Ooops. Something went wrong. Take a look at the following list and fill the form again:" 
  end

  def create_array_of_errors_for(presenter, talk)
    error_messages = []
    errors = talk.errors.messages
    errors = errors.merge presenter.errors.messages
    errors.each_pair do |key, value|
      error_message = "#{key.to_s.capitalize}: "
      value.each do |error|
        error_message += "#{error.to_s.capitalize}. "
      end
      error_messages << error_message
    end
    error_messages
  end
end


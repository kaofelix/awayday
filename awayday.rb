require 'rack-flash'
require 'sinatra/base'
require 'sinatra/redirect_with_flash'
require 'sinatra/assetpack'
require 'mongoid'
require 'haml'

Dir["./models/**/*.rb"].each { |model| require model }
Dir["./helpers/**/*.rb"].each { |helper| require helper }

class AwayDayApp < Sinatra::Base
  set :root, File.dirname(__FILE__)
  register Sinatra::AssetPack

  enable :sessions
  use Rack::Flash, :sweep => true

  DEADLINE = Time.new(2011, 9, 29, 9, 0, 0, "-03:00")

  assets do
    serve '/css', from: '/assets/css'
    serve '/images', from: '/assets/images'
    serve '/fonts', from: '/assets/fonts'

    css :awayday, [ 'css/awayday.css' ]
    css_compression :sass
  end

  after do
    session[:params], session[:errors] = {}, {} unless status == 302
  end

  get '/' do
    redirect "/talks", flash[:error] = "Submissions closed." if deadline_reached?

    session[:params] ||= {}
    haml :form, :locals => {:durations => Talk::DURATIONS, :categories => Talk::CATEGORIES, :params => session[:params]}
  end

  post '/talk' do
    talk = Talk.new :title => params[:title],
      :summary => params[:summary],
      :category => params[:category],
      :duration => params[:duration]

    presenter = Presenter.where(:name => params[:name], :email => params[:email]).first
    presenter ||= Presenter.new :name => params[:name], :email => params[:email]
    presenter.talks << talk

    if talk.valid? & presenter.valid?
      presenter.save
      redirect "/", flash[:notice] = success_message_for(presenter)
    else
      session[:errors] = errors_in(presenter, talk)
      session[:params] = copy_of params
      redirect "/", flash[:error] = error_message
    end
  end

  get '/talks' do
    haml :talks, :locals => {:talks => Talk.all}
  end

  get '/talks.csv' do
    csv = CsvHelper.csv_from Talk.all

    attachment("talks_" + Time.now.strftime("%m-%d-%Y") + ".csv")
    response.headers['Content-Type'] = "text/csv;charset=utf-8"
    response.write(csv)
  end

  get '/faq' do
    haml :faq
  end

  private

  def success_message_for(presenter)
    "Congratulations #{presenter.name}. Your proposal was sent."
  end

  def error_message
    "Ooops. Something went wrong. Take a look at the following list:"
  end

  def errors_in(presenter, talk)
    presenter.errors.messages.merge talk.errors.messages
  end

  def copy_of(params)
    params_copy = {}
    params.each_pair do |key, value|
      params_copy[key.to_sym] = value
    end
    params_copy
  end

  def deadline_reached?
    Time.new.localtime("-03:00") > DEADLINE
  end

end


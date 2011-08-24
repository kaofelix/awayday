require './awayday'
# MongoDB configuration
Mongoid.configure do |config|
  if ENV['MONGOLAB_URI']
    conn = Mongo::Connection.from_uri(ENV['MONGOLAB_URI'])
    uri = URI.parse(ENV['MONGOLAB_URI'])
    config.master = conn.db(uri.path.gsub(/^\//, ''))
  else
    config.master = Mongo::Connection.new.db("dev")
  end
end

run AwayDayApp

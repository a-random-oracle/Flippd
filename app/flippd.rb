require 'dotenv'
Dotenv.load

require_relative 'db/init'

require 'sinatra'
require 'sinatra/multi_route'
require 'rack-flash'

require_relative 'helpers/resources'

class Flippd < Sinatra::Application
  register Sinatra::MultiRoute
  use Rack::Session::Cookie, secret: ENV['COOKIE_SECRET'] + Time.now.strftime('%s')
  use Rack::Flash

  before do
    @version = "0.0.5"
  end
end

require_relative 'routes/init'

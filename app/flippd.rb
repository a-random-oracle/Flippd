require 'dotenv'
Dotenv.load

require_relative 'db/init'

require 'sinatra'
require 'sinatra/multi_route'
require 'rack-flash'

Dir[File.join(File.dirname(__FILE__), 'policies', '*.rb')].each { |file| require file }

class Flippd < Sinatra::Application
  register Sinatra::MultiRoute
  use Rack::Session::Cookie, secret: ENV['COOKIE_SECRET']
  use Rack::Flash

  before do
    @version = "0.0.4"
  end
end

require_relative 'routes/init'

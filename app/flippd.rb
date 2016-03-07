require 'dotenv'
Dotenv.load

require_relative 'db/init'

require 'sinatra'
require 'sinatra/multi_route'
require 'rack-flash'

Dir[File.join(File.dirname(__FILE__), 'helpers', '*.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__), 'helpers', 'resource_loaders', '*.rb')].each { |file| require file }

class Flippd < Sinatra::Application
  register Sinatra::MultiRoute
  use Rack::Session::Cookie, secret: ENV['COOKIE_SECRET'] + Time.now.strftime('%s')
  use Rack::Flash

  before do
    @version = "0.0.5"
  end
end

require_relative 'routes/init'

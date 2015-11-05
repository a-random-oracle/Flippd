require 'open-uri'
require 'json'
require 'omniauth'

class Flippd < Sinatra::Application
  before do
    # Load in the configuration (at the URL in the project's .env file)
    @users = JSON.load(open(ENV['CONFIG_URL'] + "users.json")) rescue {}
    @groups = JSON.load(open(ENV['CONFIG_URL'] + "groups.json")) rescue {}
  end

  if ENV['AUTH'] == "GOOGLE"
    require 'omniauth-google-oauth2'
    use OmniAuth::Strategies::GoogleOauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
    get('/auth/new') { redirect to('/auth/google_oauth2') }
  else
    use OmniAuth::Strategies::Developer
    get('/auth/new') { redirect to('/auth/developer') }
  end

  before do
    @user = session[:user]
  end

  route :get, :post, '/auth/:provider/callback' do
    auth_hash = env['omniauth.auth']

    email = auth_hash.info.email
    group = @users.keys.find{|k| @users[k].include?(email)} || "guest"
    level = @groups[group] || 0

    session[:user] = {
      name: auth_hash.info.name,
      id: auth_hash.uid,
      email: email,
      group: group,
      level: level
    }

    origin = env['omniauth.origin'] || '/'
    redirect to(origin)
  end

  get '/auth/failure' do
    flash[:error] = "Could not sign you in due to: #{params[:message]}"
    origin = env["HTTP_REFERER"] || '/'
    redirect to(origin)
  end

  get '/auth/destroy' do
    session.delete(:user)
    origin = env["HTTP_REFERER"] || '/'
    redirect to(origin)
  end
end

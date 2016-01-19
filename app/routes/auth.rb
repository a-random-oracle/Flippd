require 'omniauth'
require 'json'

class Flippd < Sinatra::Application
  if ENV['AUTH'] == "GOOGLE"
    require 'omniauth-google-oauth2'
    use OmniAuth::Strategies::GoogleOauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
    get('/auth/new') { redirect to('/auth/google_oauth2') }
  else
    use OmniAuth::Strategies::Developer
    get('/auth/new') { redirect to('/auth/developer') }
  end

  before do
    # Load in the configuration (at the URL in the project's .env file)
    @users = JSON.load(open(ENV['CONFIG_URL'] + "users.json")) rescue {}
    @permissions = JSON.load(open(ENV['CONFIG_URL'] + "permissions.json")) rescue {}

    @user = AnonUser.instance
    if session.key?(:user_id) then
      @user = User.get(session[:user_id]) || AnonUser.instance
    end
  end

  route :get, :post, '/auth/:provider/callback' do
    auth_hash = env['omniauth.auth']

    email = auth_hash.info.email
    name = auth_hash.info.name
    group = @users.keys.find{|k| @users[k].include?(email)} || "guest"
    permissions = @permissions[group] || []

    user = User.first_or_new({ email: email }, { name: name, permissions: permissions })
    user.name = name if user.name != name
    user.permissions = permissions if user.permissions != permissions
    user.save() # will short-circuit if unchanged

    session[:user_id] = user.id

    origin = env['omniauth.origin'] || '/'
    redirect to(origin)
  end

  get '/auth/failure' do
    flash[:error] = "Could not sign you in due to: #{params[:message]}"
    origin = env["HTTP_REFERER"] || '/'
    redirect to(origin)
  end

  get '/auth/destroy' do
    session.delete(:user_id)
    origin = env["HTTP_REFERER"] || '/'
    redirect to(origin)
  end
end

module Helpers
  def sign_in(from: '/')
    if ENV['AUTH'] == "GOOGLE"
      require 'omniauth-google-oauth2'
      
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        :provider => 'google_oauth2',
        :uid => '123545',
        :info => {
          :name => "Test User",
          :email => "test-user@example.com",
          :first_name => "Test",
          :last_name => "User"
          }
        })
      
      visit from
      click_on 'Sign In' if page.has_link?('Sign In')
    else
      OmniAuth.config.test_mode = false
      visit from
      click_on 'Sign In' if page.has_link?('Sign In')

      fill_in 'Name', with: 'Test User'
      fill_in 'Email', with: 'test-user@example.com'
      click_on 'Sign In'
    end
  end

  def fail_to_sign_in(from: '/')
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:developer] = 'Invalid credentials'.to_sym
    visit from
    click_on 'Sign In' if page.has_link?('Sign In')
  end
  
  def sign_out
    click_on 'Sign Out'
  end
end

OmniAuth.config.logger.level = Logger::UNKNOWN

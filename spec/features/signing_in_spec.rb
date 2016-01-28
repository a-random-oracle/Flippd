feature "Signing in" do
  context "with valid credentals" do
    before(:each) { sign_in }

    it "displays the user's name" do
      expect(page).to have_content 'test-user@example.com'
    end

    it "displays a sign out link" do
      expect(page).to have_content 'Sign Out'
    end

    it "displays a sign in link after signing out" do
      click_on 'Sign Out'

      expect(page).to have_content 'Sign In'
    end
  end

  context "redirects" do
    it "to the current page after signing in" do
      sign_in from: '/videos/fundamentals-ruby-ruby'
      expect(current_path).to eq('/videos/fundamentals-ruby-ruby')
    end

    it "to the root page after signing in directly" do
      sign_in from: '/auth/new'
      expect(current_path).to eq('/')
    end
  end
end

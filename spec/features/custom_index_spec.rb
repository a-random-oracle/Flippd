feature "A custom index page is displayed by rendering ERB from the configuration URL" do
  before(:each) { visit('/') }

  it "renders plain text from the index template" do
    expect(page).to have_content 'Explaining Ruby to Intelligent Koalas'
  end

  it "renders HTML from the index template" do
    expect(page).to have_css 'h1'
  end
end

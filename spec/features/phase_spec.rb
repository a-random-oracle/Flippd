feature "A phase page" do
  before(:each) { visit('/phases/fundamentals') }

  it "contains the phase's title" do
    within('#main') do
      expect(page).to have_content 'Fundamentals'
    end
  end

  it "contains the phase's summary" do
    expect(page).to have_content "This part of the module covers all of the essential concepts, tools and techniques that you'll need to be build habitable software in Ruby."
  end

  it "contains the title of every topic" do
    within('#topics') do
      expect(page).to have_content "Ruby"
      expect(page).to have_content "Approach"
      expect(page).to have_content "Tools"
    end
  end

  it "contains the summary of every topic" do
    expect(page).to have_content "An introduction to Ruby, which is the - purely object-oriented and somewhat functional - programming language used in DAMS."
    expect(page).to have_content "A very light introduction to software engineering processes, and a look at some of the challenges you might face when using a reactive (Agile) approach."
    expect(page).to have_content "A brief introduction to three of the key tools used in DAMS."
  end

  it "contains a link to every video in this phase" do
    titles = {
      'Ruby' => 'fundamentals-ruby-ruby',
      'Ruby Gems' => 'fundamentals-ruby-ruby-gems',
      'Planning vs. reacting' => 'fundamentals-approach-planning-reacting',
      'TDD and RSpec' => 'fundamentals-approach-tdd-rspec',
      'Test doubles' => 'fundamentals-approach-test-doubles',
      'Ruby Parser' => 'fundamentals-tools-ruby-parser',
      'Vagrant' => 'fundamentals-tools-vagrant',
      'Git' => 'fundamentals-tools-git'
      }

    titles.each do |title, id|
      expect(page).to have_link title, href: "/videos/#{id}"
    end
  end
end

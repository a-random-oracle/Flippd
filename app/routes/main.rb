require 'open-uri'
require 'json'

class Flippd < Sinatra::Application
  before do
    # Load in the configuration (at the URL in the project's .env file)
    @module = JSON.load(open(ENV['CONFIG_URL'] + "module.json"))
    @phases = @module['phases']

    @phases.each do |phase|
      phase['topics'].each do |topic|
        topic['videos'].each do |video|
          if video["tags"]
            video["tags"].each do |tag|
              Tag.first_or_create({ :video_id => video["id"],
                                    :text => tag,
                                    :modifiable => false })
            end
          end
        end
      end
    end
  end

  get '/' do
    erb open(ENV['CONFIG_URL'] + "index.erb").read
  end

  get '/phases/:title' do
    @phase = nil
    @phases.each do |phase|
      @phase = phase if phase['title'].downcase.gsub(" ", "_") == params['title']
    end

    pass unless @phase
    erb :phase
  end
end

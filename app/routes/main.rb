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
              Tag.first_or_create({ :video_id => video["id"], :text => tag },
                                  { :video_id => video["id"], :text => tag })
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

  get '/videos/:id' do
    all_videos = []
    @phases.each do |phase|
      phase['topics'].each do |topic|
        topic['videos'].each do |video|
          all_videos << video
        end
      end
    end

    @phases.each do |phase|
      phase['topics'].each do |topic|
        topic['videos'].each do |video|
          if video["id"] == params['id']
            @phase = phase
            @video = video

            index = nil
            all_videos.each_with_index do |vid, ind|
              index = ind if vid["id"] == video["id"]
            end

            @next_video = all_videos[index + 1] unless index + 1 > all_videos.size
            @previous_video = all_videos[index - 1] unless index - 1 < 0
          end
        end
      end
    end

    pass unless @video
    erb :video
  end
  
  post '/videos/:id/add_tag' do
    if @user.has_permission? :add_tag and params['text'] and params['text'] != ""
      Tag.create({ :video_id => params['id'], :text => params['text'] })
    end
    
    video_page_tag_section = '/videos/' + params['id'] + '#tags'
    redirect to video_page_tag_section
  end
end

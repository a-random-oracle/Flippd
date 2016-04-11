class Flippd < Sinatra::Application
  before do
    # Load in the configuration (at the URL in the project's .env file)
    @module = Resources::MODULE.load()
    @phases = Resources::PHASES.load()
  end

  get '/' do
    erb Resources::INDEX_PAGE.load()
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
end

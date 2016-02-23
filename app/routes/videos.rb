class Flippd < Sinatra::Application
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
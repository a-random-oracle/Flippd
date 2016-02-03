require 'sanitize'

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
  
  post '/videos/:id/add_tag' do
    if params['text'] and @user.has_permission? :add_tag
      sanitised_text = Sanitize.clean(params['text'])
      if sanitised_text != ""
        Tag.create({ :video_id => params['id'], :text => sanitised_text })
      end
    end
    
    video_page_tag_section = '/videos/' + params['id'] + '#tags'
    redirect to video_page_tag_section
  end

  post '/videos/:id/delete_tag' do
    if @user.has_permission? :delete_tag and params['tag_id']
      tag = Tag.get(params['tag_id'])
      tag.destroy if tag and tag.modifiable
    end

    video_page_tag_section = '/videos/' + params['id'] + '#tags'
    redirect to video_page_tag_section
  end
end
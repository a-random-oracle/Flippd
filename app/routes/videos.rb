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
    if params['tag_id'] and @user.has_permission? :delete_tag
      tag = Tag.get(params['tag_id'])
      tag.destroy if tag and tag.modifiable
    end

    video_page_tag_section = '/videos/' + params['id'] + '#tags'
    redirect to video_page_tag_section
  end

  post '/videos/:id/add_comment' do
    if params['text'] and @user.has_permission? :leave_comment
      sanitised_text = Sanitize.clean(params['text'])
      if sanitised_text != ""
        Comment.create({ :video_id => params['id'],
                         :author => @user.id,
                         :text => sanitised_text })
      end
    end

    video_page_comments_section = '/videos/' + params['id'] + '#comments'
    redirect to video_page_comments_section
  end

  post '/videos/:id/delete_comment' do
    if params['comment_id'] and @user.has_permission? :moderate_comments
      comment = Comment.get(params['comment_id'])
      comment.destroy if comment
    end

    video_page_comments_section = '/videos/' + params['id'] + '#comments'
    redirect to video_page_comments_section
  end
end
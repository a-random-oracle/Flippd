require 'sanitize'

class Flippd < Sinatra::Application
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
end
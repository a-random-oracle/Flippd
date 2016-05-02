require 'sanitize'

class Flippd < Sinatra::Application
  post '/videos/:id/add_comment' do
    if params['text'] and @user.has_permission? :leave_comment
      sanitised_text = Sanitize.clean(params['text'])
      if sanitised_text != ""
        if params['parent']
          Comment.create({ :video_id => params['id'],
                           :author => @user.id,
                           :text => sanitised_text,
                           :parent => params['parent'] })
        else
          Comment.create({ :video_id => params['id'],
                           :author => @user.id,
                           :text => sanitised_text })
        end
      @user.award_karma
      end
    end

    video_page_comments_section = '/videos/' + params['id'] + '#comments'
    redirect to video_page_comments_section
  end
  
  post '/videos/:id/edit_comment' do
    if params['comment_id'] and params['text']
      sanitised_text = Sanitize.clean(params['text'])
      
      if sanitised_text != ""
        comment = Comment.get(params['comment_id'])
        
        if comment
          is_own_editable_comment = (@user.has_permission? :edit_own_comment and @user.id == comment.author.to_i)
          if @user.has_permission? :edit_any_comment or is_own_editable_comment
            comment.update(:text => sanitised_text)
          end
        end
      end
    end
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
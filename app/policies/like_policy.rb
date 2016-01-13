class LikePolicy < ApplicationPolicy
  attr_reader :user, :like

  def initialize(user, like)
    @user = user
    @like = like
  end

  def create?
    user_already_liked_video = Like.all(:video_id => @like.video_id, :user_id => @like.user_id).count > 0
    
    @user.respond_to? :has_permission? and @user.has_permission? :like_video and not user_already_liked_video
  end
end
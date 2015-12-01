class Like
  include DataMapper::Resource

  property :id, Serial
  property :video_id, Integer
  property :user_id, String
end

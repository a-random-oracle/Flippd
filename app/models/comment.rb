class Comment
  include DataMapper::Resource

  property :id, Serial
  property :video_id, String, required: true, length: 150
  property :author, String, required: true, length: 150
  property :text, Text, required: true, length: 200
  property :time, EpochTime, required: true, default: Time.now
  property :parent, String
end
class Tag
  include DataMapper::Resource

  property :id, Serial
  property :video_id, String, required: true, length: 150
  property :text, String, required: true, length: 150
end
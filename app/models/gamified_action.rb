class GamifiedAction
  include DataMapper::Resource

  property :id, Serial
  property :user_id, String, required: true, length: 150
  property :action_type, String, required: true, length: 150
  property :occurred_on, EpochTime, required: true, default: lambda{ |r,p| Time.now}
  property :details, Json, default: {}, lazy: false
end
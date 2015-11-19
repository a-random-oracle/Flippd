class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true, length: 150
  property :email, String, required: true, length: 150
  property :permissions, Json, required: false, default: [], lazy: false

  def has_permission?(permission)
    !permissions.nil? && permissions.include?(permission.to_s)
  end
end

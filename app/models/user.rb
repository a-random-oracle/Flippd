require "singleton"

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true, length: 150
  property :email, String, required: true, length: 150
  property :permissions, Json, required: false, default: [], lazy: false

  def is_logged_in?
    true
  end

  def has_permission?(permission)
    !permissions.nil? && permissions.include?(permission.to_s)
  end
end

class GuestUser
  include Singleton

  def self.method_missing(*args, &block)
    nil
  end

  def is_logged_in?
    false
  end

  def has_permission?(permission)
    false
  end
end

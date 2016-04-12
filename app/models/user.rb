require "singleton"

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true, length: 150
  property :email, String, required: true, length: 150
  property :permissions, Json, required: false, default: [], lazy: false

  def self.from_oauth(oauth_data)
    # Fetch authorisation data (from the URL in the project's .env file)
    Resources::USERS.with do |users_json|
      Resources::PERMISSIONS.with do |permissions_json|
        email = oauth_data.info.email
        name = oauth_data.info.name
        group = users_json.keys.find{ |k| users_json[k].include?(email) } || "guest"
        permissions = permissions_json[group] || []

        user_resource = DatabaseResource.new(User, { :email => email }, { :name => name, :permissions => permissions })
        user_resource.with do |user|
          user.update_specific_attributes({ :name => name, :permissions => permissions })
        end

        user_resource.load()
      end
    end
  end

  def update_specific_attributes(attributes)
    attributes.each do |attribute, value|
      if attribute_get(attribute) != value then
        attribute_set(attribute, value)
      end
    end
  end

  def is_logged_in?
    true
  end

  def has_permission?(permission)
    !permissions.nil? && permissions.include?(permission.to_s)
  end
end

class UnauthenticatedUser
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

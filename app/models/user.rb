require "singleton"

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true, length: 150
  property :email, String, required: true, length: 150
  property :permissions, Json, required: false, default: [], lazy: false

  def self.from_oauth(oauth_data)
    # Fetch authorisation data (from the URL in the project's .env file)
    users_json = JSON.load(open(ENV['CONFIG_URL'] + "users.json")) rescue {}
    permissions_json = JSON.load(open(ENV['CONFIG_URL'] + "permissions.json")) rescue {}

    email = oauth_data.info.email
    name = oauth_data.info.name
    group = users_json.keys.find{ |k| users_json[k].include?(email) } || "guest"
    permissions = permissions_json[group] || []

    user = self.first_or_new({ :email => email }, { :name => name, :permissions => permissions })
    user.update_specific_attributes({ :name => name, :permissions => permissions })

    user
  end

  def update_specific_attributes(attributes)
    attributes.each do |attribute, value|
      if attribute_get(attribute) != value then
        attribute_set(attribute, value)
      end
    end
    save # This will short-circuit if no attributes have changed
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

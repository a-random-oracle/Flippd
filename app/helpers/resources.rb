class Resources
  INDEX_PAGE  = Resource.new(ENV['CONFIG_URL'] + 'index.erb', :erb)
  MODULE      = Resource.new(ENV['CONFIG_URL'] + 'module.json', :json)
  PHASES      = Resource.new(ENV['CONFIG_URL'] + 'module.json', :json)
  USERS       = Resource.new(ENV['CONFIG_URL'] + 'users.json', :json)
  PERMISSIONS = Resource.new(ENV['CONFIG_URL'] + 'permissions.json', :json)
end
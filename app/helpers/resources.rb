class Resources
  INDEX_PAGE  = Resource.new(ENV['CONFIG_URL'] + 'index.erb', ERBLoader)
  MODULE      = Resource.new(ENV['CONFIG_URL'] + 'module.json', JSONLoader)
  PHASES      = Resource.new(ENV['CONFIG_URL'] + 'module.json', JSONLoader)
  USERS       = Resource.new(ENV['CONFIG_URL'] + 'users.json', JSONLoader)
  PERMISSIONS = Resource.new(ENV['CONFIG_URL'] + 'permissions.json', JSONLoader)
end
class Resources
  INDEX_PAGE  = Resource.new(ENV['CONFIG_URL'] + 'index.erb', :erb, ERBValidator)
  MODULE      = Resource.new(ENV['CONFIG_URL'] + 'module.json', :json, ModuleValidator)
  PHASES      = Resource.new(ENV['CONFIG_URL'] + 'module.json', :json, PhasesValidator)
  USERS       = Resource.new(ENV['CONFIG_URL'] + 'users.json', :json, UsersValidator)
  PERMISSIONS = Resource.new(ENV['CONFIG_URL'] + 'permissions.json', :json, PermissionsValidator)
end
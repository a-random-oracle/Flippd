class Resources
  INDEX_PAGE  = Resource.new(ENV['CONFIG_URL'] + 'index.erb', ERBLoader, :not_found, ERBValidator)
  MODULE      = Resource.new(ENV['CONFIG_URL'] + 'module.json', JSONLoader, {}, ModuleValidator)
  PHASES      = Resource.new(ENV['CONFIG_URL'] + 'module.json', PhasesLoader, {}, PhasesValidator)
  USERS       = Resource.new(ENV['CONFIG_URL'] + 'users.json', JSONLoader, {}, UsersValidator)
  PERMISSIONS = Resource.new(ENV['CONFIG_URL'] + 'permissions.json', JSONLoader, {}, PermissionsValidator)
end
class Resources
  INDEX_PAGE  = FileResource.new(ENV['CONFIG_URL'] + 'index.erb', ERBLoader, ERBValidator, :not_found)
  MODULE      = FileResource.new(ENV['CONFIG_URL'] + 'module.json', JSONLoader, ModuleValidator, {})
  USERS       = FileResource.new(ENV['CONFIG_URL'] + 'users.json', JSONLoader, UsersValidator, {})
  PERMISSIONS = FileResource.new(ENV['CONFIG_URL'] + 'permissions.json', JSONLoader, PermissionsValidator, {})
  PHASES      = Resource.new(PhasesLoader, PhasesValidator, {})
end
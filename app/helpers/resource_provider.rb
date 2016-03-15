class ResourceProvider
  class << self
    INDEX       = ENV['CONFIG_URL'] + 'index.erb'
    MODULE      = ENV['CONFIG_URL'] + 'module.json'
    USERS       = ENV['CONFIG_URL'] + 'users.json'
    PERMISSIONS = ENV['CONFIG_URL'] + 'permissions.json'
    
    def get_index()
      index = ERBLoader.load(INDEX)
      index if ERBValidator.validate(index)
    end
    
    def get_module()
      mod = JSONLoader.load(MODULE)
      mod if ModuleValidator.validate(mod)
    end
    
    def get_phases()
      phases = get_module()['phases']
      phases if PhasesValidator.validate(phases)
    end
    
    def get_users()
      users = JSONLoader.load(USERS)
      users if UsersValidator.validate(users)
    end
    
    def get_permissions()
      permissions = JSONLoader.load(PERMISSIONS)
      permissions if PermissionsValidator.validate(permissions)
    end
  end
end
class ResourceProvider
  class << self
    INDEX       = ENV['CONFIG_URL'] + 'index.erb'
    MODULE      = ENV['CONFIG_URL'] + 'module.json'
    USERS       = ENV['CONFIG_URL'] + 'users.json'
    PERMISSIONS = ENV['CONFIG_URL'] + 'permissions.json'
    
    def get_index(&block)
      index = ERBLoader.load(INDEX)
      validate_resource(ERBValidator, index, &block)
    end
    
    def get_module(&block)
      mod = JSONLoader.load(MODULE)
      validate_resource(ModuleValidator, mod, &block)
    end
    
    def get_phases(&block)
      mod = JSONLoader.load(MODULE)
      
      if validate_resource(ModuleValidator, mod, &block)
        phases = mod['phases']
        validate_resource(PhasesValidator, phases, &block)
      end
    end
    
    def get_users(&block)
      users = JSONLoader.load(USERS)
      validate_resource(UsersValidator, users, &block)
    end
    
    def get_permissions(&block)
      permissions = JSONLoader.load(PERMISSIONS)
      validate_resource(PermissionsValidator, permissions, &block)
    end
    
    private
    
    def validate_resource(validator, resource, &block)
      if resource and validator.validate(resource)
        handle_possible_block(resource, &block)
      end
    end
    
    def handle_possible_block(resource)
      if block_given?
        yield resource
      else
        resource
      end
    end
  end
end
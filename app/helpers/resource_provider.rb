class ResourceProvider
  class << self
    INDEX       = ENV['CONFIG_URL'] + 'index.erb'
    MODULE      = ENV['CONFIG_URL'] + 'module.json'
    USERS       = ENV['CONFIG_URL'] + 'users.json'
    PERMISSIONS = ENV['CONFIG_URL'] + 'permissions.json'
    
    def get_index()
      ERBLoader.load(INDEX)
    end
    
    def get_module()
      JSONLoader.load(MODULE)
    end
    
    def get_phases()
      get_module()['phases']
    end
    
    def get_users()
      JSONLoader.load(USERS)
    end
    
    def get_permissions()
      JSONLoader.load(PERMISSIONS)
    end
  end
end
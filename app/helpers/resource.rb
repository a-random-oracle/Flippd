class Resource
  attr_reader :loader
  attr_reader :validator
  attr_reader :default
  attr_reader :cached_value
  attr_reader :cache_last_updated
  attr_accessor :cache_timeout

  def initialize(loader, validator=nil, default=nil, cache_timeout=1800)
    @loader = loader
    @validator = validator
    @default = default
    @cache_last_updated = Time.new(0)
    @cache_timeout = cache_timeout
  end
  
  def load(force_reload=false)
    if ((Time.now - @cache_last_updated).to_i > @cache_timeout) || force_reload
      begin
        loaded_resource = @loader.load(self)
        @cached_value = validate(loaded_resource) ? loaded_resource : @default
      rescue
        @cached_value = @default
      ensure
        @cache_last_updated = Time.now
      end
    end
    @cached_value
  end
  
  def with
    yield load
  end
  
  private
  
  def validate(loaded_resource)
    @validator ? @validator.validate(loaded_resource) : true
  end
end
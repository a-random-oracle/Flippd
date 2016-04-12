class Resource
  attr_reader :loader
  attr_reader :validator
  attr_reader :default
  attr_reader :cached_value

  def initialize(loader, validator=nil, default=nil)
    @loader = loader
    @validator = validator
    @default = default
    @cached_value = :not_set
  end
  
  def load
    if @cached_value == :not_set
      begin
        loaded_resource = @loader.load(self)
        @cached_value = validate(loaded_resource) ? loaded_resource : @default
      rescue
        @cached_value = @default
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
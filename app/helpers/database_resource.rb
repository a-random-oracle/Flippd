require_relative 'resource'
require_relative 'resource_loaders/database_entry_loader'

class DatabaseResource < Resource
  attr_reader :table
  attr_reader :selectors
  
  def initialize(table, *selectors)
    super(DatabaseEntryLoader, nil, nil)
    @table = table
    @selectors = selectors
    @cache_timeout = 5
  end

  def with
    resource = load
    yield resource
    resource.save
  end
end
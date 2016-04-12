require_relative 'resource'

class DatabaseResource < Resource
  attr_reader :table
  attr_reader :selectors
  
  def initialize(table, *selectors)
    super(DatabaseEntryLoader, nil, table.new)
    @table = table
    @selectors = selectors
  end

  def with
    resource = load
    yield resource
    resource.save
  end
end
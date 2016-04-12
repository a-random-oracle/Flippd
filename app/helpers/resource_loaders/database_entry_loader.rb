class DatabaseEntryLoader
  def self.load(resource)
    resource.table.first_or_new(*resource.selectors)
  end
end
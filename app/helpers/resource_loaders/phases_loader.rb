class PhasesLoader
  def self.load(resource)
    Resources::MODULE.load['phases']
  end
end
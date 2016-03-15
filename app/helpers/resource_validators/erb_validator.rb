class ERBValidator
  def self.validate(resource)
    begin
      ERB.new(resource).result
    rescue
      return false
    end
    true
  end
end
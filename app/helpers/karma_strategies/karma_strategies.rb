require_relative '../event'
require_relative '../resources'

module KarmaStrategies
  @karma_values = Resources::KARMA.load

  def self.get_event_value(event)
    @karma_values[self.json_id_from_event_type(event.type)] || 0
  end

  def self.json_id_from_event_type(event_type)
    event_type.to_s.gsub('_', '-')
  end
end
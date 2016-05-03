require_relative '../helpers/event'

class KarmaListener
  def initialize(event_bus)
    event_bus.attach(:add_comment, self)
    event_bus.attach(:complete_quiz, self)

    @karma_values = JSON.load(open(ENV['CONFIG_URL'] + "karma.json"))
    @karma_awarders = { :add_comment   => lambda { |event| get_event_value(event) },
                        :complete_quiz => lambda { |event| (event.details['result'].percentage * get_event_value(event)) / 100 } }
  end

  def notify(event)
    event.user.award_karma(@karma_awarders[event.type].call(event))
  end

  private

  def get_event_value(event)
    @karma_values[json_id_from_event_type(event.type)] || 0
  end

  def json_id_from_event_type(event_type)
    event_type.to_s.gsub('_', '-')
  end
end
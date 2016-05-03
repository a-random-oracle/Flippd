class KarmaListener
  def initialize(event_bus)
    event_bus.attach(:add_comment, self)
    event_bus.attach(:complete_quiz, self)

    @karma_values = JSON.load(open(ENV['CONFIG_URL'] + "karma.json"))
    @karma_awarders = { :add_comment   => lambda { |event_type, details| get_event_value(event_type) },
                        :complete_quiz => lambda { |event_type, details|
                                                   (details['result'].percentage * get_event_value(event_type)) / 100 } }
  end

  def notify(event_type, user, details)
    user.award_karma(@karma_awarders[event_type].call(event_type, details))
  end

  private

  def get_event_value(event_type)
    @karma_values[json_id_from_event_type(event_type)] || 0
  end

  def json_id_from_event_type(event_type)
    event_type.to_s.gsub('_', '-')
  end
end
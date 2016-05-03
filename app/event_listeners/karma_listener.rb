require_relative '../helpers/event'
Dir[File.join(File.dirname(__FILE__), '..', 'helpers', 'karma_strategies', '**', '*.rb')].each { |file| require file }

class KarmaListener
  def initialize(event_bus)
    event_bus.attach(:add_comment, self)
    event_bus.attach(:complete_quiz, self)
  end

  def notify(event)
    karma_strategy = KarmaListener::find_karma_strategy(event)
    karma_strategy.award_karma(event) if karma_strategy
  end
  
  def self.find_karma_strategy(event)
    karma_strategy = KarmaStrategies.constants.find do |strategy|
      KarmaStrategies.const_get(strategy)::STRATEGY_FOR == event.type
    end
    KarmaStrategies.const_get(karma_strategy)
  end
end
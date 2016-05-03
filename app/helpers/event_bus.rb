require_relative 'event'

class EventBus
  def initialize
    @event_map = {}
  end

  def attach(event_type, listener)
    @event_map[event_type] ||= []
    @event_map[event_type] << listener
  end

  def notify(event_type, user, details={})
    event = Event.new(event_type, user, details)
    @event_map[event_type].each { |listener| listener.notify(event) }
  end
end
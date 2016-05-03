require_relative 'event'

class EventBus
  def initialize
    @event_map = {}
  end

  def attach(listener, event_types)
    event_types_list = event_types.respond_to?('each') ? event_types : [event_types]
    event_types_list.each do |event_type|
      @event_map[event_type] ||= []
      @event_map[event_type] << listener
    end
  end

  def notify(event_type, user, details={})
    event = Event.new(event_type, user, details)
    @event_map[event_type].each { |listener| listener.notify(event) }
  end
end
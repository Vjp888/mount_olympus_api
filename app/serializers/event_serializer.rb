class EventSerializer
  def initialize(events)
    @data = events
  end

  def format_collections
    hashmap = Hash.new {|hash,key| hash[key] = [] }
    @data.each do |event|
      hashmap[event.sport] << event.event_name
    end
    hashmap
  end

  def render_output
    data = format_collections
    output = {events: []}
    data.each do |key, value|
      output[:events] << {
        sport: key,
        events: value
      }
    end
    return output
  end
end

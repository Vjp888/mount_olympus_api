class MedalistsSerializer
  def initialize(event)
    @event = event
    @olympians = event.olympians
  end

  def render_output
    medals = @event.olympian_events.where.not(medal: nil).where(olympian: @olympians)
    {
      event: @event.event_name,
      medalists: format_medalists(medals)
    }
  end

  private

  def format_medalists(medals)
    medals.map do |medal|
      olympian = medal.olympian
      {
        name: olympian.name,
        team: olympian.team,
        age: olympian.age,
        medal: medal.medal
      }
    end
  end
end

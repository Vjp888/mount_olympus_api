class Api::V1::EventsController < ApplicationController
  def index
    events = Event.select(:event_name, :sport).distinct
    if events.present?
      data = EventSerializer.new(events).render_output
      status = 200
    else
      data = {error: 'No events in system'}
      status = 404
    end
      render :json => data, status: status
  end
end

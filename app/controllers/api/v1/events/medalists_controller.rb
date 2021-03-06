class Api::V1::Events::MedalistsController < ApplicationController
  def show
      event = event_exist?(params[:event_id])
    if event
      data = MedalistsSerializer.new(event).render_output
      status = 200
    else
      data = { error: 'No event found'}
      status = 404
    end
    render :json => data, status: status
  end

  private

  #This is a result of a weird quirk of Rails 5.2 it doesn't like to return nil when it fails

  def event_exist?(id)
    begin
      Event.find(id)
    rescue
      nil
    end
  end
end

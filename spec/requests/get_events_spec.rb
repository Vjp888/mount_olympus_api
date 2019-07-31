require 'rails_helper'

describe 'Get /api/v1/events' do
  describe 'happy path' do
    it 'should return all events by sport' do
      event_4 = Event.create!(games: 'angry', event_name: 'ddd', sport: 'fencing')
      event_5 = Event.create!(games: 'angry', event_name: 'ddd', sport: 'fencing')
      event_6 = Event.create!(games: 'angry', event_name: 'f', sport: 'fencing')
      event_1 = Event.create!(games: 'angry', event_name: 'bbbbb', sport: 'curling')
      event_2 = Event.create!(games: 'angry', event_name: 'bbbbb', sport: 'curling')
      event_3 = Event.create!(games: 'angry', event_name: 'cccc', sport: 'curling')

      get '/api/v1/events'

      data = JSON.parse(response.body)

      expect(response.code).to eq('200')
      expect(data['events'].count).to eq(2)
    end
  end

  describe 'sad path' do
    it 'returns an error when no events are present' do
      get '/api/v1/events'

      data = JSON.parse(response.body)

      expect(response.code).to eq('404')
      expect(data['error']).to eq("No events in system")
    end
  end
end

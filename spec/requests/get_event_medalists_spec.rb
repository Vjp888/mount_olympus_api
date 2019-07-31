require 'rails_helper'

describe 'GET /api/v1/events/:id/medalists' do
  describe 'happy path' do
    it 'should return all medalists (if any) for a given event' do
      olympian_1 = Olympian.create!(name: 'bob', sex: 'M', age: 22, weight: 120, height: 140, team: "US", sport: 'basketweaving')
      olympian_2 = Olympian.create!(name: 'martha', sex: 'F', age: 200, weight: 90, height: 90, team: "GA", sport: 'fencing')
      event_1 = Event.create!(games: 'angry', event_name: 'aaaaaa', sport: 'blah')
      event_2 = Event.create!(games: 'meh', event_name: 'bbbbb', sport: "spoooooooooorts")
      OlympianEvent.create!(olympian: olympian_1, event: event_1, medal: "Bronze")
      OlympianEvent.create!(olympian: olympian_2, event: event_1, medal: "Gold")
      OlympianEvent.create!(olympian: olympian_2, event: event_2, medal: "Gold")

      get "/api/v1/events/#{event_1.id}/medalists"

      data = JSON.parse(response.body)

      expect(data['event']).to eq(event_1.event_name)
      expect(data['medalists'].count).to eq(2)
    end
  end

  describe 'sad pathing' do
    it 'raises error if no event is present' do
      get "/api/v1/events/1000000/medalists"
      data = JSON.parse(response.body)

      expect(data['error']).to eq('No event found')
    end

    it 'returns no medalists if none are present' do
      event_1 = Event.create!(games: 'angry', event_name: 'aaaaaa', sport: 'blah')
      get "/api/v1/events/#{event_1.id}/medalists"
      data = JSON.parse(response.body)

      expect(data['event']).to eq(event_1.event_name)
      expect(data['medalists'].count).to eq(0)
    end
  end
end

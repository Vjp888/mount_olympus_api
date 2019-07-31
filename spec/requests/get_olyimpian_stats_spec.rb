require 'rails_helper'

describe 'Get request to /api/v1/olympian_stats' do
  describe 'happy path' do
    it 'returns a statistics pack for all olympians in the database' do
      Olympian.create!(name: 'bob', sex: 'M', age: 20, weight: 100, height: 140, team: "US", sport: 'basketweaving')
      Olympian.create!(name: 'rob', sex: 'M', age: 30, weight: 50, height: 90, team: "GA", sport: 'fencing')
      Olympian.create!(name: 'alex', sex: 'M', age: 40, weight: 75, height: 90, team: "GA", sport: 'fencing')
      Olympian.create!(name: 'martha', sex: 'F', age: 50, weight: 90, height: 90, team: "GA", sport: 'fencing')
      Olympian.create!(name: 'patricia', sex: 'F', age: 60, weight: 60, height: 90, team: "GA", sport: 'fencing')
      Olympian.create!(name: 'victoria', sex: 'F', age: 70, weight: 30, height: 90, team: "GA", sport: 'fencing')

      get '/api/v1/olympian_stats'

      data = JSON.parse(response.body)

      expect(response.code).to eq('200')
      expect(data['olympian_stats']['total_competing_olympians']).to eq(6)
      expect(data['olympian_stats']['average_weight']['unit']).to eq('kg')
      expect(data['olympian_stats']['average_weight']['male_olympians']).to eq(75.0)
      expect(data['olympian_stats']['average_weight']['female_olympians']).to eq(60.0)
      expect(data['olympian_stats']['average_age']).to eq(45.0)
    end
  end

  describe 'sad path' do
    it 'returns an error if no olympians are present' do
      get '/api/v1/olympian_stats'

      data = JSON.parse(response.body)

      expect(response.code).to eq('404')
      expect(data['error']).to eq('No Olympians')
    end
  end
end

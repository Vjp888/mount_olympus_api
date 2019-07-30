require 'rails_helper'

describe 'Get request to /api/v1/olympians' do
  describe 'happy path' do
    it 'returns all olympians with their total medals' do
      olympian_1 = Olympian.create!(name: 'bob', sex: 'M', age: 22, weight: 120, height: 140, team: "US", sport: 'basketweaving')
      olympian_2 = Olympian.create!(name: 'martha', sex: 'F', age: 200, weight: 90, height: 90, team: "GA", sport: 'fencing')
      event_1 = Event.create!(games: 'angry', event_name: 'aaaaaa')
      event_2 = Event.create!(games: 'meh', event_name: 'bbbbb')
      OlympianEvent.create!(olympian: olympian_1, event: event_1, medal: "bronze")
      OlympianEvent.create!(olympian: olympian_1, event: event_2, medal: "gold")

      get '/api/v1/olympians'

      data = JSON.parse(response.body)

      expect(response.code).to eq('200')
      expect(data['olympians'].count).to eq(2)
      expect(data['olympians'].first['name']).to eq(olympian_1.name)
      expect(data['olympians'].first['age']).to eq(olympian_1.age)
      expect(data['olympians'].first['sport']).to eq(olympian_1.sport)
      expect(data['olympians'].first['team']).to eq(olympian_1.team)
      expect(data['olympians'].first['total_medals_won']).to eq(2)
      expect(data['olympians'].last['name']).to eq(olympian_2.name)
    end

    it 'returns the youngest olympian when passed in age parameter' do
      olympian_2 = Olympian.create!(name: 'martha', sex: 'F', age: 30, weight: 90, height: 90, team: "GA", sport: 'fencing')
      olympian_3 = Olympian.create!(name: 'maxy', sex: 'F', age: 40, weight: 90, height: 90, team: "GA", sport: 'fencing')
      olympian_1 = Olympian.create!(name: 'bob', sex: 'M', age: 22, weight: 120, height: 140, team: "US", sport: 'basketweaving')

      get '/api/v1/olympians?age=youngest'

      data = JSON.parse(response.body)

      expect(response.code).to eq('200')
      expect(data.count).to eq(1)
      expect(data.first['name']).to eq(olympian_1.name)
      expect(data.first['age']).to eq(olympian_1.age)
      expect(data.first['sport']).to eq(olympian_1.sport)
      expect(data.first['team']).to eq(olympian_1.team)
      expect(data.first['total_medals_won']).to eq(0)
    end

    it 'returns the oldest olympian when passed in age parameter' do
      olympian_2 = Olympian.create!(name: 'martha', sex: 'F', age: 30, weight: 90, height: 90, team: "GA", sport: 'fencing')
      olympian_3 = Olympian.create!(name: 'maxy', sex: 'F', age: 40, weight: 90, height: 90, team: "GA", sport: 'fencing')
      olympian_1 = Olympian.create!(name: 'bob', sex: 'M', age: 22, weight: 120, height: 140, team: "US", sport: 'basketweaving')

      get '/api/v1/olympians?age=oldest'

      data = JSON.parse(response.body)

      expect(response.code).to eq('200')
      expect(data.count).to eq(1)
      expect(data.first['name']).to eq(olympian_3.name)
      expect(data.first['age']).to eq(olympian_3.age)
      expect(data.first['sport']).to eq(olympian_3.sport)
      expect(data.first['team']).to eq(olympian_3.team)
      expect(data.first['total_medals_won']).to eq(0)
    end
  end

  describe 'sad path' do
    it 'returns an error when no olympians are in database' do
      get '/api/v1/olympians'
      data = JSON.parse(response.body)

      expect(data['error']).to eq("No Olympians, Please Seed Database")
    end

    it 'returns an error when and invalid age query is made' do
      Olympian.create!(name: 'martha', sex: 'F', age: 30, weight: 90, height: 90, team: "GA", sport: 'fencing')
      get '/api/v1/olympians?age=steve'
      data = JSON.parse(response.body)

      expect(data['error']).to eq("No Olympians, Please Seed Database")
    end
  end
end

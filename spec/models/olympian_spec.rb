require 'rails_helper'

RSpec.describe Olympian, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :sex }
    it { should validate_presence_of :age }
    it { should validate_presence_of :height }
    it { should validate_presence_of :weight }
    it { should validate_presence_of :team }
    it { should validate_presence_of :sport }
  end

  describe 'relationships' do
    it { should have_many :olympian_events}
    it { should have_many(:events).through(:olympian_events) }
  end

  describe 'instance methods' do
    describe 'total_medals_won' do
      it 'should return a count of all medals an olympian has earned' do
        oly = Olympian.create!(name: 'bob', sex: 'M', age: 22, weight: 120, height: 140, team: "US", sport: 'basketweaving')
        event_1 = Event.create!(games: 'angry', event_name: 'aaaaaa', sport: "spoooooooooorts")
        event_2 = Event.create!(games: 'meh', event_name: 'bbbbb', sport: "spoooooooooorts")
        event_3 = Event.create!(games: 'ha', event_name: 'ccc', sport: "spoooooooooorts")
        OlympianEvent.create!(olympian: oly, event: event_1, medal: "bronze")
        OlympianEvent.create!(olympian: oly, event: event_2, medal: "gold")
        OlympianEvent.create!(olympian: oly, event: event_3, medal: nil)

        result = oly.total_medals_won

        expect(result).to eq(2)
      end
    end
  end

  describe 'class methods' do
    describe 'params_check' do
      before :each do
        @oly_1 = Olympian.create!(name: 'bob', sex: 'M', age: 20, weight: 120, height: 140, team: "US", sport: 'basketweaving')
        @oly_2 = Olympian.create!(name: 'marry', sex: 'M', age: 30, weight: 120, height: 140, team: "US", sport: 'basketweaving')
        @oly_3 = Olympian.create!(name: 'yancy', sex: 'M', age: 40, weight: 120, height: 140, team: "US", sport: 'basketweaving')
      end
      it 'should return single olympians if youngest or oldest is sent' do
        youngest = Olympian.params_check("youngest")
        oldest = Olympian.params_check("oldest")
        bad_params = Olympian.params_check("roger")
        no_params = Olympian.params_check

        expect(youngest.first).to eq(@oly_1)
        expect(youngest.count).to eq(1)
        expect(oldest.first).to eq(@oly_3)
        expect(bad_params).to eq([])
        expect(no_params.count).to eq(3)
      end
    end
  end
end

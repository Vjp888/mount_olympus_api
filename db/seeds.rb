# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

OlympianEvent.destroy_all
Olympian.destroy_all
Event.destroy_all

CSV.foreach('db/data/olympic_data_2016.csv', headers: true) do |data|
  olympics_data = data.to_h
  begin
    olympian = Olympian.find_by(name: olympics_data['Name'])
    unless olympian
      olympian = Olympian.create!(
        name: olympics_data['Name'],
        sex: olympics_data['Sex'],
        age: olympics_data['Age'],
        weight: olympics_data['Weight'],
        height: olympics_data['Height'],
        sport: olympics_data['Sport'],
        team: olympics_data['Team']
      )
    end
  rescue
    puts olympian.error
  end

  begin
    event = Event.find_by(event_name: olympics_data['Event'])
    unless event
      event = Event.create!(
        games: olympics_data['Games'],
        event_name: olympics_data['Event'])
        olympian.events << event
      else
        olympian.events << event
    end
  rescue
    puts event.error
  end

  begin
    medal = OlympianEvent.find_by!(olympian_id: olympian.id, event_id: event.id)
    unless olympics_data['Medal'] == "NA"
      medal.update!(medal: olympics_data['Medal'])
    else
      medal.medal = nil
    end
  rescue
    puts medal.error
  end
end

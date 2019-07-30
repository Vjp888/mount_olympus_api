class OlympiansSerializer
  def initialize(olympians)
    @data = olympians
  end

  def render_json
    @data.map do |oly|
      {
        name: oly.name,
        team: oly.team,
        age: oly.age,
        sport: oly.sport,
        total_medals_won: oly.total_medals_won
      }
    end
  end
end

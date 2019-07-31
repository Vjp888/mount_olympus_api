class StatisticsSerializer
  def initialize(olympians)
    @data = olympians
  end

  def total_competing_olympians
    @data.count
  end

  def average_age
    @data.all.average(:age).to_f.round(2)
  end

  def weight_average(gender)
    @data.where(sex: gender).average(:weight).to_f.round(2)
  end

  def json_output
      {
      olympian_stats: {
        total_competing_olympians: total_competing_olympians,
        average_weight: {
          unit: 'kg',
          male_olympians: weight_average('M'),
          female_olympians: weight_average('F')
        },
        average_age: average_age
      }
    }
  end
end

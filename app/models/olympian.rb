class Olympian < ApplicationRecord
  validates_presence_of :name,
                        :age,
                        :weight,
                        :height,
                        :team,
                        :sex,
                        :sport
  has_many :olympian_events
  has_many :events, through: :olympian_events

  def total_medals_won
    self.olympian_events.where.not(medal: nil).count
  end

  def self.params_check(age = nil)
    case age.to_s.downcase
    when "youngest"
      self.order(age: :asc).limit(1)
    when "oldest"
      self.order(age: :desc).limit(1)
    when ""
      self.all
    else
      []
    end
  end
end

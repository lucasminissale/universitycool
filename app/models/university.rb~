class University < ActiveRecord::Base

  validates :name, :uniqueness => true

  def self.populate
    Budget::University.get_universities.each do |uni|
      self.create :name => uni
    end
  end
end

class PopulateUniversities < ActiveRecord::Migration
  def up
    Budget::University.get_universities.each do |uni|
      University.create :name => uni
    end
  end

  def down
  end
end

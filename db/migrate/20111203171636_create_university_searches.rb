class CreateUniversitySearches < ActiveRecord::Migration
  def change
    create_table :university_searches do |t|
      t.string :university_name

      t.timestamps
    end
  end
end

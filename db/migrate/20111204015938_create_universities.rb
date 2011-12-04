class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.string :name
      t.string :fundation
      t.string :address
      t.string :city
      t.string :rector
      t.integer :students

      t.timestamps
    end
  end
end

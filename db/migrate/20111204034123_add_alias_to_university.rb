class AddAliasToUniversity < ActiveRecord::Migration
  def change
    add_column :universities, :alias, :string 
  end
end

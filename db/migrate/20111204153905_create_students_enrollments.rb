class CreateStudentsEnrollments < ActiveRecord::Migration
  def change
    create_table :students_enrollments do |t|
      t.string :university
      t.string :career
      t.integer :last_enrollment
      t.integer :reenrollment
      t.integer :previous_enrollment

      t.timestamps
    end
  end
end

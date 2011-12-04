class StudentsEnrollment < ActiveRecord::Base

  def desertion_relation
    reenrollment.to_f / previous_enrollment
  end
  
  def self.populate
    students = Budget::StudentParser.new("#{Rails.root}/lib/budget/students/students.xls")
    students.get_data.each do |d|
     self.create :university => d[0], :career => d[1],
                 :last_enrollment => d[2], :reenrollment => d[3], 
                 :previous_enrollment => d[4]
   end
 end
end

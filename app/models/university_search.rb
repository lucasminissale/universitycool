class UniversitySearch < ActiveRecord::Base
  with_options :presence => true do |s|
     s.validates :university_name
   end
end

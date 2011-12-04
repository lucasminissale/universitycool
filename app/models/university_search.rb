class UniversitySearch < ActiveRecord::Base
  validates :university_name, :presence => true
end

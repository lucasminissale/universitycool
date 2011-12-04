class BudgetUniversity
  include Geokit::Geocoders
  
  attr_accessor :university
  attr_accessor :university_data
  
  def initialize(object)
    self.university = object
    self.university_data = UniversityData.where(:university_id => self.university.id).order(:date_from).limit(4)
  end
  
  def salaries
    ["125000", "130000", "140000", "155000", "160000", "170000", "185000", "190000", "195000", "225000", "330000", "440000"]
  end
  
  def students
  end
  
  def name
    university.alias
  end
  
  def address
    university.address
  end
  
  def budget
    
  end
  
  def map
    location = MultiGeocoder.geocode(self.address)
    "http://maps.google.com/maps/api/staticmap?center=#{address}Y&zoom=14&size=300x256&maptype=roadmap
    &markers=color:blue|label:S|#{location.ll}&sensor=false"
  end
  
end

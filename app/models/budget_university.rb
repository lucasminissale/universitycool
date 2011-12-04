class BudgetUniversity
  include Geokit::Geocoders
  
  attr_accessor :university
  
  def initialize(object)
    university = object
  end
  
  def salaries
    ["125000", "130000", "140000", "155000", "160000", "170000", "185000", "190000", "195000", "225000", "330000", "440000"]
  end
  
  def name
    "Universidad Argentina de la empresa"
  end
  
  def address
    "Ciudad de la paz 2909, Ciudad autonoma de Buenos Aires"
  end
  
  def map
    location = MultiGeocoder.geocode(self.address)
    "http://maps.google.com/maps/api/staticmap?center=#{address}Y&zoom=14&size=300x256&maptype=roadmap
    &markers=color:blue|label:S|#{location.ll}&sensor=false"
  end
  
end

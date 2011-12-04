require 'httparty'

class University < ActiveRecord::Base
  include Geokit::Geocoders
  include HTTParty

  base_uri 'ajax.googleapis.com/'
  default_params :output => 'json'
  format :json
  
  validates :name, :uniqueness => true

  has_many :university_datas

  def logo
    query = "universidad de " + self.name + " logo"
    response = self.class.get('/ajax/services/search/images', :query => {:v => "1.0", :q => query})
    response.to_hash["responseData"]["results"].first["url"]
  end

  def self.populate
    Budget::University.get_universities.each do |uni|
      self.create :name => uni
    end
  end
  
  def map
     location = MultiGeocoder.geocode(self.address)
     "http://maps.google.com/maps/api/staticmap?center=#{address}Y&zoom=14&size=300x256&maptype=roadmap
     &markers=color:blue|label:S|#{location.ll}&sensor=false"
   end
end

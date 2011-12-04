require 'httparty'

class University < ActiveRecord::Base
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
end

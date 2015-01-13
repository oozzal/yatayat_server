class Location < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude

  has_many :reports

  scope :search_by_name, -> (name) { where("name like ?", "%#{name}%") }
  scope :search_by_lat_lng, -> (lat_lng) { where(latitude: lat_lng[:latitude], longitude: lat_lng[:longitude]) }

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    # if name is already set
    # and latitude, longitude obtained by this name
    if obj.name
      result = Geocoder.search(obj.name).first
      obj.address = result.address
    else
      result = results.first
      obj.address = result.address
      obj.name = result.data['address_components'].first['short_name']
    end
  end

  geocoded_by :name
  after_validation :geocode, :reverse_geocode

end


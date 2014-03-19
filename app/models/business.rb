class Business < ActiveRecord::Base
	has_many :ads

	acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng
  
  def serves?(userGPS)
  	userll = Geokit::LatLng.new(userGPS[:lat], userGPS[:lng])
  	businessll = Geokit::LatLng.new(self.lat, self.lng)
 		businessll.distance_to(userll) <= self.radius
  end
end

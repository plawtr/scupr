class Business < ActiveRecord::Base
	has_many :ads

	acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng
  
  def serves?(userGPS)
    kms_to(userGPS) <= self.radius
  end

  def kms_to(userGPS)
    userll = Geokit::LatLng.new(userGPS[:lat], userGPS[:lng])
    businessll = Geokit::LatLng.new(self.lat, self.lng)
    businessll.distance_to(userll)
  end

  def as_json
    ad = ads.first
    puts ad
    puts self.ads
    puts self.ads.first
    puts self
    puts "**" * 50
    {id: id, name: name, lat: lat, lng: lng, radius: radius, ad: { id: ad.id, bucket_image: ad.bucket_image, image: ad.full_image, caption: ad.caption}}
  end

end

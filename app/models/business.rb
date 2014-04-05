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
    {id: id, name: name, lat: lat, lng: lng, radius: radius*1000, phone: phone, ad: { id: ad.id, bucket_image: ad.bucket_image, image: ad.full_image, caption: ad.caption, tags: ad.tag_list}}
  end

  def generate_pass 
    ad = ads.first
    pass_json = Tempfile.new('pass_json')
    pass_json.write({"Business" => name, "Visits" => 0, "RVisits" => 5, "longitude" => lng, "latitude" => lat}.to_json)
    pass_json.close

    pass_strip = Tempfile.new('pass_strip')
    pass_strip.binmode
    pass_strip.write(open(ad.image.url(:medium)).read)
    pass_strip.close

    request = RestClient::Request.new(
      :method => :post, 
      :url => "http://#{ENV['PASSLOT']}@api.passslot.com/v1/templates/67318005/pass",
      :payload => {
        :multipart => true, 
        :"values" => pass_json.open, 
        :"strip@2x" => pass_strip.open
      }
    )
    response = request.execute
    JSON.parse(response)
  end

  def generate_coupon 
    ad = ads.first
    coupon_json = Tempfile.new('coupon_json')
    coupon_json.write({"Business" => name, "Promotion" => "20% OFF", "Caption" => "Darjeeling Tea", "DateIssued" => Time.now.strftime("%m/%d/%Y"), "Expires" => "two weeks", "longitude" => lng, "latitude" => lat}.to_json)
    coupon_json.close

    coupon_strip = Tempfile.new('coupon_strip')
    coupon_strip.binmode
    coupon_strip.write(open(ad.image.url(:medium)).read)
    coupon_strip.close

    request = RestClient::Request.new(
      :method => :post, 
      :url => "http://#{ENV['PASSLOT']}@api.passslot.com/v1/templates/67958001/pass",
      :payload => {
        :multipart => true, 
        :"values" => coupon_json.open, 
        :"strip@2x" => coupon_strip.open
      }
    )
    response = request.execute
    JSON.parse(response)
  end
end

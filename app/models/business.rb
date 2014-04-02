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

  # def pass_for(ad)
    
  #   raw_pass_path         = Dir.mktmpdir
  #   FileUtils.cp_r(Dir['app/assets/certificate/StoreCard.raw/*'], raw_pass_path)

  #   # the below is breaking json file for sign_pass!
  #   pass = JSON.parse(File.open("app/assets/certificate/pass.json").read)
  #   pass["locations"].first["longitude"] = lng
  #   pass["locations"].first["latitude"] = lat
  #   pass["organizationName"] = name
  #   pass["logoText"] = name
  #   tempfile = Tempfile.new(['Yonder', '.json'], raw_pass_path)
  #   tempfile.binmode
  #   tempfile.write JSON.pretty_generate(pass)
  #   tempfile.close

  #   puts raw_pass_path
  #   puts  "raw_pass_path ***"*50

  #   certificate_path      = "app/assets/certificate/Certificates.p12"
  #   wwdr_certificate_path = "app/assets/certificate/AWDRCA.pem"
  #   certificate_password  = ENV['certificate_password']
  #   pass_output_path      = Dir.mktmpdir+"/new.pkpass"
    
  #   puts pass_output_path
  #   puts  "pass_output_path ***"*50

  #   pass_signer = SignPass.new(raw_pass_path, certificate_path, certificate_password, wwdr_certificate_path, pass_output_path)
  #   pass_signer.sign_pass!

  #   return pass_output_path
  # end
end

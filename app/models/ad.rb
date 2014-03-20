class Ad < ActiveRecord::Base

	has_attached_file :image, :styles => { :large => "600x600", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_presence_of :image, :caption

  belongs_to :business

  def bucket_image
  	image.url(:thumb) # .split("?").first
  end

  def full_image
    image.url(:medium) # .split("?").first
  end

  def as_json(user_GPS)
  	{id: id, bucket_image: bucket_image, image: full_image, caption: caption, business_name: business.name, business_GPS: {lat: business.lat, lng: business.lng}, distance: business.kms_to(user_GPS)}
  end

  # def as_json_for(user_GPS)
  #   as_json.merge(distance: business.kms_to(user_GPS))
  # end
  
end

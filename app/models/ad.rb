class Ad < ActiveRecord::Base

	has_attached_file :image, :styles => { :large => "600x600", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_presence_of :image

  has_attached_file :pass

  belongs_to :business

  acts_as_taggable

  def bucket_image
  	image.url(:thumb) # .split("?").first
  end

  def full_image
    image.url(:medium) # .split("?").first
  end

  def time_ago
    diff_seconds = (Time.now - updated_at).to_i
    case diff_seconds
      when 0..59
        "#{diff_seconds}s"
      when 60..3599
        "#{diff_seconds/60}m"
      when 3600 .. (3600*24-1)
        "#{diff_seconds/3600}h"
      when (3600*24) .. (3600*24*365)
        "#{diff_seconds/(3600*24)}d"
    else
      start_time.strftime("%-d %b")
    end
  end

  def as_json(user_GPS)
  	{id: id, bucket_image: bucket_image, image: full_image, caption: caption, business_id: business.id, business_name: business.name, business_GPS: {lat: business.lat, lng: business.lng}, distance: business.kms_to(user_GPS), business_phone: business.phone, updated_ago: time_ago, tags: tag_list}
  end

end

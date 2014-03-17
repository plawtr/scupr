class Ad < ActiveRecord::Base

	has_attached_file :image, :styles => { :large => "600x600", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_presence_of :image, :caption

  belongs_to :business

  def bucket_image
  	image.url(:thumb).split("?").first
  end

  def as_json
  	{id: id, image: bucket_image}
  end
  
end

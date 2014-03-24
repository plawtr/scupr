class AdPresenter
  DEFAULT_SIZE = :medium

	def initialize(ad = nil, size = DEFAULT_SIZE)
		@ad = ad
		@size = size || DEFAULT_SIZE
	end

  def is_mappable?
  	self.tiff_jpeg? && self.has_gps?
  end

  def tiff_jpeg?
  	["image/jpeg", "image/tiff"].include?(@ad.image_content_type)
  end

  def has_gps?
		!exif_gps.nil?
  end

  def exif_gps
  	EXIFR::JPEG.new(open(self.image_path)).gps
  end

  def image_path
		@ad.image.url(@size).split("?").first
  end

  def longitude
  	exif_gps.to_h[:longitude] 
  end

  def latitude
  	exif_gps.to_h[:latitude]
  end

  def method_missing(method)
    @ad.send(method) rescue nil
  end

end
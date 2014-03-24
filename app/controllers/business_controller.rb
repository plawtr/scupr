class BusinessController < ApplicationController
  def create
  	@business = Business.new(name: params["business-name"], lat: params["business-lat"] , lng: params["business-lng"], radius: params["business-radius"].to_f/1000)
    if @business.save 
      @ad = Ad.new(caption: params["ad-caption"], business_id: @business.id, image: params["file"])
      if @ad.save
        puts "Ad saved!"
      else
        puts "error ad"
      end
      puts "saved!!!"
  	else
  		puts "Error!!"
  	end

  end

  # private
  # 	def business_params
  # 		params.require(:business).permit(:name, :lng, :lat, :radius)
  # 	end
end

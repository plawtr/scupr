class BusinessController < ApplicationController
  def create
  	@business = Business.new(name: params["business-name"], lat: params["business-lat"] , lng: params["business-lng"], radius: params["business-radius"].to_f/1000)
  	if @business.save
  		puts "saved"
  	else
  		puts "Error!!"
  	end

  end

  # private
  # 	def business_params
  # 		params.require(:business).permit(:name, :lng, :lat, :radius)
  # 	end
end

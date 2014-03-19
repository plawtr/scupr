class AdsController < ApplicationController
	
	def index
		@ads = params[:coords] ? Ad.all.select{|ad| ad.business.serves?(user_GPS)} : Ad.all
  	render :json => { 
  			:ads => @ads.as_json }
	end

	def show
		@ad = Ad.find_by_id(params[:id])
  	render :json => { 
  			:ad => @ad.as_json }
	end

private
	def user_GPS
		coords = params[:coords]
		{lng: coords[:longitude], lat: coords[:latitude]}
	end
end


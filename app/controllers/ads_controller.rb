class AdsController < ApplicationController
	
	def index
		if params[:coords]
			@ads = params[:tag] ? Ad.tagged_with(params[:tag]) : Ad.all
			@ads = @ads.select{|ad| ad.business.serves?(user_GPS)}
  		render :json => {	:ads => @ads.sort_by{|ad| ad.updated_at}.reverse.as_json(user_GPS).sort_by{|ad| ad[:distance]} }
  	else
  		render :text => "Oops, it looks like we could not locate you! "
  	end
	end

	def show
		@ad = Ad.find_by_id(params[:id])
  	render :json => { 
  			:ad => @ad.as_json(user_GPS) }
	end

	def user_GPS
		coords = params[:coords]
		{lng: coords[:longitude], lat: coords[:latitude]}
	end
end


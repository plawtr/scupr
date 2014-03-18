class AdsController < ApplicationController
	def index
		@ads = Ad.all
  	render :json => { 
  			:ads => @ads.as_json }
	end

	def show
		@ad = Ad.find_by_id(params[:id])
  	render :json => { 
  			:ad => @ad.as_json }
	end

end

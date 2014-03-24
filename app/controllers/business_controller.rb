class BusinessController < ApplicationController
  def create
    @business = Business.new(
      name: params["business-name"], 
      lat: params["business-lat"], 
      lng: params["business-lng"], 
      radius: params["business-radius"].to_f/1000
    )
    if @business.save
      @ad = Ad.new(
        caption: params["ad-caption"], 
        image: params["file"],
        business_id: @business.id
      )
    else 
      render :json => { :business => @business.errors.messages }
    end

    if @ad.save
      render :json => { :business => @business.as_json }
    else
      render :json => { :business => @business.as_json.merge(@ad.errors.messages)}
    end

  end
end

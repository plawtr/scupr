class BusinessController < ApplicationController
  def create

    @business = Business.find_or_create_by(id: params["business-id"])

    @business.assign_attributes(
      name: params["business-name"], 
      lat: params["business-lat"], 
      lng: params["business-lng"], 
      radius: params["business-radius"].to_f/1000,
      phone: params["business-phone"]
    )

    @ad = @business.ads.first || Ad.new()

    if @business.save
      @ad.assign_attributes(
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

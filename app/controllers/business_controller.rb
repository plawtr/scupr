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

    @business_user = BusinessUser.find_or_create_by(uuid: params["business-uuid"], business_id: params["business-id"])

    @ad = @business.ads.first || Ad.new()

    if @business.save

      @ad.tag_list = params["ad-tags"]
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

  def show
    @business = Business.find_by(id: params["id"])
    render :json => { :business => @business.as_json }
  end

  def create_pass
    @business = Business.find_by(id: params["business_id"])
    pass = @business.generate_pass 
    render :json => { :pass_url => pass["url"].as_json } 
  end

  def create_coupon
    @business = Business.find_by(id: params["business_id"])
    coupon = @business.generate_coupon 
    render :json => { :pass_url => coupon["url"].as_json } 
  end
end

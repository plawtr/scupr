require 'spec_helper'

describe Business do

  it "should know if a user is within its radius" do 
  	@ozone = Business.create(name: "Ozone", lng: -122.02344807, lat: 37.33256234, radius: 0.1)
		@userGPS = { lng: -122.02344807, lat: 37.33256234}
		expect(@ozone.serves?(@userGPS)).to be_true
  end

  it "should know if a user is outside its radius" do 
  	@ozone = Business.create(name: "Ozone", lng: -122.02344807, lat: 37.33256234, radius: 0.1)
		@userGPS = { lng: 0, lat: 0}
		expect(@ozone.serves?(@userGPS)).to be_false
  end

end

Given(/^it has radius and location$/) do
  @ozone.lng = -122.02344807
  @ozone.lat = 37.33256234
  @ozone.radius = 100.0/1000 # meters?
  @ozone.save
end

Given(/^I am within the business radius$/) do
  @GPS = {lng: -122.02344807, lat: 37.33256234}
end

When(/^I request all ads with my GPS data$/) do
  get "/ads?coords%5Blatitude%5D=#{@GPS[:lat]}&coords%5Blongitude%5D=#{@GPS[:lng]}&coords%5Baccuracy%5D=10&coords%5Baltitude%5D=0&coords%5Bheading%5D=345.85&coords%5Bspeed%5D=6.56&coords%5BaltitudeAccuracy%5D=-1&timestamp=Wed+Mar+19+2014+10%3A23%3A45+GMT%2B0000+(GMT)"
end

Then(/^I receive one json ad$/) do
  expect(last_response.body).to eq("{\"ads\":[{\"id\":#{@ad.id},\"bucket_image\":\"#{@ad.image.url(:thumb)}\",\"image\":\"#{@ad.image.url(:medium)}\",\"caption\":\"#{@ad.caption}\",\"business_name\":\"#{@ad.business.name}\",\"business_GPS\":{\"lat\":#{@ad.business.lat},\"lng\":#{@ad.business.lng}}}]}")
end

Given(/^I am outside the business radius$/) do
  @GPS = {lng: 0, lat: 0}
end

Then(/^I do not receive any ads$/) do
  expect(last_response.body).to eq("{\"ads\":[]}")
end

Given(/^several businesses with individual ads exist$/) do
  @ozone = Business.create(name: 'Ozone', lat: 51.5246511, lng: -0.0868513, radius: 1)
  @jane  = Business.create(name: 'Salvation Jane', lat: 51.5243051, lng: -0.0874449, radius: 1)
  @pod   = Business.create(name: 'Pod', lat: 51.5130042, lng: -0.0931957, radius: 0.05)

	@ad1 = Ad.create(image: File.open(Rails.root.join("test/img/1.jpg")), 
									    caption: 'Ozone open for business', 
									business_id: @ozone.id)
	@ad2 = Ad.create(image: File.open(Rails.root.join("test/img/2.jpg")), 
									    caption: 'Salvation Jane open for business', 
									business_id: @jane.id)
	@ad3 = Ad.create(image: File.open(Rails.root.join("test/img/1.jpg")), 
									    caption: 'Pod open for business', 
									business_id: @pod.id) 
end

Given(/^I am within two business radii$/) do 
  @GPS = {lng: -0.0874449, lat: 51.5243051}
end

Then(/^I receive two json ads$/) do
    expect(last_response.body).to eq(expect(last_response.body).to eq("{\"ads\":[#{@ad.as_json.to_json}]}"))

end

Then(/^I receive two json ads in distance order$/) do
  pending # express the regexp above with the code you wish you had
end

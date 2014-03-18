Given(/^a business exists$/) do
  @ozone = Business.create(name: "Ozone")
end

Given(/^it has an ad$/) do
  @ad = Ad.create(image: File.open(Rails.root.join("test/img/1.jpg")), caption: "Test Caption 1", business_id: @ozone.id)
end

Given(/^I request all ads$/) do
  get '/ads'
end

Then(/^I receive a json ad$/) do
  expect(last_response.body).to eq("{\"ads\":[{\"id\":#{@ad.id},\"bucket_image\":\"#{@ad.image.url(:thumb).split("?").first}\",\"image\":\"#{@ad.image.url(:medium).split("?").first}\",\"caption\":\"#{@ad.caption}\",\"business_name\":\"#{@ad.business.name}\"}]}")
end

Then(/^I receive all json ads$/) do
  expect(last_response.body).to eq("{\"ads\":[{\"id\":#{@ad.id},\"bucket_image\":\"#{@ad.image.url(:thumb).split("?").first}\",\"image\":\"#{@ad.image.url(:medium).split("?").first}\",\"caption\":\"#{@ad.caption}\",\"business_name\":\"#{@ad.business.name}\"},{\"id\":#{@ad2.id},\"bucket_image\":\"#{@ad2.image.url(:thumb).split("?").first}\",\"image\":\"#{@ad2.image.url(:medium).split("?").first}\",\"caption\":\"#{@ad2.caption}\",\"business_name\":\"#{@ad2.business.name}\"}]}")
end

Given(/^it has another ad$/) do
  @ad2 = Ad.create(image: File.open(Rails.root.join("test/img/2.jpg")), caption: "Test Caption 2", business_id: @ozone.id)
end


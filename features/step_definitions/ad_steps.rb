When(/^I request an individual ad$/) do
  get "/ads/#{@ad.id}"
end

Then(/^I receive an individual json ad$/) do
 expect(last_response.body).to eq("{\"ad\":{\"id\":#{@ad.id},\"bucket_image\":\"#{@ad.image.url(:thumb)}\",\"image\":\"#{@ad.image.url(:medium)}\",\"caption\":\"#{@ad.caption}\",\"business_name\":\"#{@ad.business.name}\",\"business_GPS\":{\"lat\":null,\"lng\":null}}}")
end




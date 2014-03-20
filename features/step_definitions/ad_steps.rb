When(/^I request an individual ad$/) do
  get "/ads/#{@ad.id}?coords%5Blatitude%5D=#{@GPS[:lat]}&coords%5Blongitude%5D=#{@GPS[:lng]}&coords%5Baccuracy%5D=10&coords%5Baltitude%5D=0&coords%5Bheading%5D=345.85&coords%5Bspeed%5D=6.56&coords%5BaltitudeAccuracy%5D=-1&timestamp=Wed+Mar+19+2014+10%3A23%3A45+GMT%2B0000+(GMT)"
end

Then(/^I receive an individual json ad$/) do
 expect(last_response.body).to eq("{\"ad\":{\"id\":#{@ad.id},\"bucket_image\":\"#{@ad.image.url(:thumb)}\",\"image\":\"#{@ad.image.url(:medium)}\",\"caption\":\"#{@ad.caption}\",\"business_name\":\"#{@ad.business.name}\",\"business_GPS\":{\"lat\":#{@ad.business.lat},\"lng\":#{@ad.business.lng}},\"distance\":0.00885025516103663}}")
end




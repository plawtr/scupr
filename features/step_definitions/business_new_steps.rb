Given(/^a client attempts to create a new business$/) do
  image = fixture_file_upload("tmp/img/1.jpg", 'image/jpeg')
  post '/business/new', {"business-name"=>"test2", "business-radius"=>"1", "business-lng"=>"2", "business-lat"=>"2", "business-id"=>"", "controller"=>"business", "action"=>"create", "ad-caption"=>"Blah!", file: image}
end

Then(/^the business should exist$/) do
 expect(Business.find_by(name: "test2")).not_to be_nil
end
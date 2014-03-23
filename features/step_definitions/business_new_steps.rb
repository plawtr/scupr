Given(/^a client attempts to create a new business$/) do
  post '/business/new', {"business-name"=>"test2", "business-radius"=>"1", "business-lng"=>"2", "business-lat"=>"2", "controller"=>"business", "action"=>"create"} 
end

Then(/^the business should exist$/) do
 expect(Business.find_by(name: "test2")).not_to be_nil
end
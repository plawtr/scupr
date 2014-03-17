Given(/^a business exists$/) do
  @ozone = Business.create(name: "Ozone")
end

Given(/^it has an ad$/) do
  Ad.create(image: File.open(Rails.root.join("test/img/1.jpg")), caption: "Test Caption 1", business_id: @ozone.id)
end

Given(/^I request all ads$/) do
  get '/ads'
end

Then(/^I receive:$/) do |string|
	expect(last_response.body).to eq string
end

Given(/^it has another ad$/) do
  Ad.create(image: File.open(Rails.root.join("test/img/2.jpg")), caption: "Test Caption 2", business_id: @ozone.id)
end
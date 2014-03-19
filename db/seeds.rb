# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

businesses = Business.create([{name: 'Ozone', lat: 51.5246511, lng: -0.0868513, radius: 0.1 }, {name: 'Salvation Jane', lat: 51.5243051, lng: -0.0874449, radius: 0.05}, {name: 'Pod', lat: 51.5130042, lng: -0.0931957, radius: 0.05}])

ads = Ad.create([      {image: File.open(Rails.root.join("tmp/img/1.jpg")), 
									    caption: 'Ozone open for business', 
									business_id: 1}, 
								       {image: File.open(Rails.root.join("tmp/img/2.jpg")), 
									    caption: 'Salvation Jane open for business', 
									business_id: 2}, 
								       {image: File.open(Rails.root.join("tmp/img/3.jpg")), 
									    caption: 'Pod open for business', 
									business_id: 3}]) 



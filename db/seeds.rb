# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

businesses = Business.create([{name: 'Ozone'}, {name: 'Salvation Jane'}, {name: 'Pod'}])

ads = Ad.create([      {image: File.open(Rails.root.join("tmp/img/1.jpg")), 
									    caption: 'Ozone open for business', 
									business_id: 1}, 
								       {image: File.open(Rails.root.join("tmp/img/2.jpg")), 
									    caption: 'Salvation Jane open for business', 
									business_id: 2}, 
								       {image: File.open(Rails.root.join("tmp/img/3.jpg")), 
									    caption: 'Pod open for business', 
									business_id: 3}]) 



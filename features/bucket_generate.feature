Feature: Show json ads in on the ads page

Background:
	Given a business exists

Scenario: Show one ad
	And it has an ad
	When I request all ads
	Then I receive:
	"""
	{"ads":[{"id":1,"image":"/system/ads/images/000/000/001/thumb/1.jpg"}]}
	"""

Scenario: Show two ads from one business
	And it has an ad
	And it has another ad
	When I request all ads
	Then I receive:
	"""
	{"ads":[{"id":2,"image":"/system/ads/images/000/000/002/thumb/1.jpg"},{"id":3,"image":"/system/ads/images/000/000/003/thumb/2.jpg"}]}
	"""
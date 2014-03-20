Feature: Show json ad in on individual pages

Background:
	Given a business exists
	And it has radius and location
	And I am within the business radius

Scenario: Show one ad
	And it has an ad
	When I request an individual ad
	Then I receive an individual json ad
Feature: Show one json ad based on user location

Background:
	Given a business exists
	And it has radius and location
	And it has an ad

Scenario: Client is within business radius
	Given I am within the business radius
	When I request all ads with my GPS data
	Then I receive one json ad

Scenario: Client is outside business radius
	Given I am outside the business radius
	When I request all ads with my GPS data
	Then I do not receive any ads
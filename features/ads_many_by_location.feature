Feature: Show one json ad based on user location

Background:
	Given several businesses with individual ads exist

Scenario: Client is inside 2 business radii
	Given I am within two business radii
	When I request all ads with my GPS data
	Then I receive two json ads


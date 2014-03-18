Feature: Show json ad in on individual pages

Background:
	Given a business exists

Scenario: Show one ad
	And it has an ad
	When I request an individual ad
	Then I receive an individual json ad
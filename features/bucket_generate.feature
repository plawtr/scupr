Feature: Show bucket json data on the ads page

Background:
	Given a business exists

Scenario: Show one ad
	And it has an ad
	When I request all ads
	Then I receive a json ad


Scenario: Show two ads from one business
	And it has an ad
	And it has another ad
	When I request all ads
	Then I receive all json ads
Feature: Premium account

	Rules:
		- mention the word "buy" and lose 5 credits
		- long messages cost 2 credits

  Questions:
    - what happens if you shout a too-long message containing the word "buy"
    - what happens if you run out of credit

	Background:
		Given the range is 100
		And the following people:
			| name     | Sean | Lucy |
			| location | 0    | 100 |

	Scenario: Test premium account features
		Given Sean has bought 30 credits
        When Sean shouts 2 over-long messages
        Then Lucy hears all Sean's messages
        And Sean should have 26 credits

    Scenario:
        Given Sean has bought 30 credits
        When Sean shouts 3 messages containing the word "buy"
        Then Lucy hears all Sean's messages
        And Sean should have 15 credits

	@todo
  	Scenario: BUG #2789
    	Given Sean has bought 30 credits
    	When Sean shouts "buy, buy buy!"
    	Then Sean should have 25 credits
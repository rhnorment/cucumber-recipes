Feature: Premium account

    Rules:
    	- mention the word "buy" and lose 5 credits per shout
    	- long messages cost 2 credits
        - you can't send a premium shout unless you have enough credits

  Questions:
    - what happens if you shout a too-long message containing the word "buy"

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
  	Scenario: Mention the word "buy" several times in the same shout
    	Given Sean has bought 100 credits
    	When Sean shouts "buy, buy buy!"
    	Then Sean should have 95 credits

    Scenario: Run out of credit
        Given Sean has bought 4 credits
        When Sean shouts a message containing the word "buy"
        Then Lucy does not hear Sean's message
        And Sean should have 4 credits

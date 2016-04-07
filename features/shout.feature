Feature: Shouty

	In order to send location-sensitive messages to people nearby
	As a shouter
	I want to broadcast messages to people near me

	Rules:
		- broadcast to all users
		- don't worry about proximity 
		- people remember everything they've heard
		- max length of message is 180 characters
	

	Background:
		Given the range is 100
		And the following people:
			| name     | Sean | Lucy | Larry |
			| location | 0    | 100  | 150   | 

	Scenario: Listener is within range
		When Sean shouts "Free bagels!"
		Then Lucy hears Sean's message

	Scenario: Listener is out of range
		When Sean shouts "Free bagels!"
		Then Larry does not hear Sean's message

	Scenario: Two Shouts
		When Sean shouts "Free bagels!"
		And Sean shouts "Free toast!"
		Then Lucy hears the following messages:
			| Free bagels! |
			| Free toast!  |

	Scenario: Message is too long
		When Sean shouts
			"""
			This is a really long message
			so long in fact that I am not going to be
			allowed to send it, at least if I am typing like this until the length is
			over the limite of 180 characters.
			over the limite of 180 characters.
			"""
		Then nobody hears Sean's message

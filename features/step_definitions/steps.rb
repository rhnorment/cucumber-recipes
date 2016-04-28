Given(/^the range is (\d+)$/) do |range|
	@network = Network.new(range.to_i)
end

Given(/^the following people:$/) do |table|
	table = table 
		.transpose
		.map_column('location') { |raw| raw.to_i }
		.hashes.each do |row|
			name =  row['name']
			location = row['location']
			people[name] = Person.new(@network, location)
	end
end

When(/^Sean shouts (\d+) messages containing the word "(.*?")$/) do |num, word|
	num.to_i.times do
		message = "Here is the message containg the word #{word}"
		sean_shout(message)
	end
end

When(/^Sean shouts (\d+) over\-long messages$/) do |num| 
	num.to_i.times do
		message = "x" * 181
		sean_shout(message)
	end
end

When(/^Sean shouts a over-long messsage$/) do
	message = "x" * 181
	sean_shout(message)
end

When(/^Sean shouts a long messsage$/) do
	message = "x" * 180
	sean_shout(message)
end

When(/^Sean shouts a message containg the word "(.*?)"$/) do |word|
	message = "A message containing the word #{word}"
	sean_shout(message)
end

When(/^Sean shouts a message containing the word "([^"]*)"$/) do |word|
 	message = "A message containing the word #{word}"
	sean_shout(message)
end

When(/^Sean shouts "(.*?)"$/) do |message|
	sean_shout(message)
end

When(/^Sean shouts$/) do |message|
  	sean_shout(message)
end

Then(/^Lucy hears Sean's message$/) do
  	expect(people['Lucy'].messages_heard).to include(messages_shouted_by['Sean'].last)
end

Then(/^(Larry|Lucy) does not hear Sean's message$/) do |listener_name|
	expect(people[listener_name].messages_heard).to_not include(messages_shouted_by['Sean'].last)
end

Then(/^nobody hears Sean's message$/) do
	people.values.each do |person|
		expect(person.messages_heard).to_not include(messages_shouted_by['Sean'].last)
	end
end

Then(/^Lucy hears the following messages:$/) do |expected_messages|
 	lucy = people['Lucy']
 	actual_messages = lucy.messages_heard.map { |message| [message] }
 	expected_messages.diff!(actual_messages)
end

Given(/^Sean has bought (\d+) credits$/) do |credits|
  people['Sean'].credits = credits.to_i
end

Then(/^Sean should have (\d+) credits$/) do |expected_credits|
  expect(people['Sean'].credits).to eql(expected_credits.to_i)
end

Then(/^Lucy hears all Sean's messages$/) do
  messages_shouted_by['Sean'].each do |message|
  	expect(people['Lucy'].messages_heard).to include(message)
  end
end





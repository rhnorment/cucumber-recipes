require 'shouty'

describe Person do 
	let(:sean) { Person.new(network, 0) }
	let(:lucy) { Person.new(network, 100) }
	let(:network) { double.as_null_object }

	it 'subscribes to the network' do
		expect(network).to receive(:subscribe)
		location = 0
		new_person = Person.new(network, location)
	end
	 
	it 'has a location' do
	 	expect(lucy.location).to eql(100)
	end

	it 'broadcasts shouts to the network' do
		message = "Free Bagels!"
		sean_location = 0
		expect(network).to receive(:broadcast).with(message, sean)
		sean.shout message
	end

	it 'remembers messages heard' do
		message = 'Free Bagels!'
		location = 100
		lucy = Person.new(network, location)
		lucy.hear(message)
		expect(lucy.messages_heard).to eql([message])
	end
end
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

	describe 'charging for shouts' do
		it "deducts 5 credits when the shouter mentions the word 'buy'" do
			sean = Person.new(network, 0)
			sean.credits = 100
			sean.shout("here is a message containing the word buy")
			expect(sean.credits).to eql(95)
		end

		it 'only charges once per shout for multiple mentions of buy' do
			sean = Person.new(network, 0)
			sean.credits = 100
			sean.shout("buy buy buy")
			expect(sean.credits).to eql(95)
		end

		it 'deducts 2 credits when the message is over 180 characters' do
			sean = Person.new(network, 0)
			sean.credits = 100
			sean.shout("x" * 181)
			expect(sean.credits).to eql(98)
		end
	end

	describe 'broadcasting shouts' do
		it 'does not broadcast messages over 180 characters when the shouter has insufficient credits' do
			sean = Person.new(network, 0)
			sean.credits = 1
			expect(network).to_not receive(:broadcast)
			sean.shout("x" * 181)
		end
	end


end


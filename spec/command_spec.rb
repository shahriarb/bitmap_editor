require 'command'

describe Command do

	it 'has a INVALID_BITMAP_ERROR constant' do
		expect(Command::INVALID_BITMAP_ERROR).to eq('This command needs a valid bitmap')
	end

	context 'calling execute' do
		it 'should raise a NotImplementedError' do
			expect {Command.new.execute}.to raise_error(NotImplementedError)
		end
	end
end
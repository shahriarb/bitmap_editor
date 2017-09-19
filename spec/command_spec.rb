require 'command'

describe Command do

	it 'has a INVALID_BITMAP_ERROR constant' do
		expect(Command::INVALID_BITMAP_ERROR).to eq('There is no image')
	end

	context 'calling execute' do
		it 'should raise a NotImplementedError' do
			expect {Command.new.execute}.to raise_error(NotImplementedError)
		end
	end
end
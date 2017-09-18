require 'command'

describe Command do
	context 'calling execute' do
		it 'should raise a NotImplementedError' do
			expect {Command.new.execute}.to raise_error(NotImplementedError)
		end
	end
end
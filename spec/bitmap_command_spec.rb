require 'bitmap_command'

describe BitmapCommand do
	context 'calling execute' do
		it 'should raise a NotImplementedError' do
			expect {BitmapCommand.new.execute}.to raise_error(NotImplementedError)
		end
	end
end
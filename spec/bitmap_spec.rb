require 'bitmap'

describe Bitmap do
	describe '#initialize' do
		context  'With wrong initial values' do
			it 'should raise ArgumentError with no initial argument' do
				expect {Bitmap.new}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with one initial argument' do
				expect {Bitmap.new(0)}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with one initial argument' do
				expect {Bitmap.new(0)}.to raise_error(ArgumentError)
			end

			it 'should raise exception with wrong initial width type' do
				expect {Bitmap.new('0',0)}.to raise_error('Width should be a valid integer')
			end

			it 'should raise exception with wrong initial height type' do
				expect {Bitmap.new(0,'0')}.to raise_error('Height should be a valid integer')
			end

			it 'should raise exception with negative width' do
				expect {Bitmap.new(-1,0)}.to raise_error('Width should be a positive integer')
			end

			it 'should raise exception with negative height' do
				expect {Bitmap.new(0,-1)}.to raise_error('Height should be a positive integer')
			end

		end



	end
end
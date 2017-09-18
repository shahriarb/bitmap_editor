require 'bitmap_utils'

describe BitmapUtils do

	it 'has a MAX_LENGTH constant with value 25O' do
		expect(BitmapUtils::MAX_LENGTH).to eq(250)
	end

	it 'has a SIZE_PARAM_ERROR constant with value "should be a valid integer between 1 and MAX_LENGTH"' do
		expect(BitmapUtils::SIZE_PARAM_ERROR).to eq("should be a valid integer between 1 and #{BitmapUtils::MAX_LENGTH}")
	end

	describe '.valid_size_param?' do
		context  'With wrong argument' do
			it 'should raise ArgumentError with no initial argument' do
				expect {BitmapUtils.valid_size_param?}.to raise_error(ArgumentError)
			end

			it 'should return false with wrong argument type' do
					expect(BitmapUtils.valid_size_param?('1')).to be false
			end

			it 'should return false with argument with value 0' do
				expect(BitmapUtils.valid_size_param?(0)).to be false
			end

			it 'should raise exception with argument more than BitmapUtils::MAX_LENGTH' do
				expect(BitmapUtils.valid_size_param?(BitmapUtils::MAX_LENGTH + 1)).to be false
			end
		end
	end

	describe '.validate_sizes' do

		context 'With wrong arguments' do
			it 'should raise ArgumentError with no argument' do
				expect {BitmapUtils.validate_sizes}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with one argument' do
				expect {BitmapUtils.validate_sizes(1)}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with two argument' do
				expect {BitmapUtils.validate_sizes(1, 'Width')}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with three argument' do
				expect {BitmapUtils.validate_sizes(1, 'Width', 1)}.to raise_error(ArgumentError)
			end

			it 'should raise exception with wrong param1 type' do
				expect {BitmapUtils.validate_sizes('1', 'Width',1, 'Height')}.to raise_error(ArgumentError,"Width #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with zero param1' do
				expect {BitmapUtils.validate_sizes(0,'Width',1, 'Height')}.to raise_error(ArgumentError,"Width #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with param1 more than BitmapUtils::MAX_LENGTH' do
				expect {BitmapUtils.validate_sizes(BitmapUtils::MAX_LENGTH + 1,'Width',1, 'Height')}.to raise_error(ArgumentError,"Width #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with wrong initial param2 type' do
				expect {BitmapUtils.validate_sizes(1,'Width','1', 'Height')}.to raise_error(ArgumentError,"Height #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with zero param2' do
				expect {BitmapUtils.validate_sizes(1,'Width',0, 'Height')}.to raise_error(ArgumentError,"Height #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with param2 more than BitmapUtils::MAX_LENGTH' do
				expect {BitmapUtils.validate_sizes(1,'Width',BitmapUtils::MAX_LENGTH + 1, 'Height')}.to raise_error(ArgumentError,"Height #{BitmapUtils::SIZE_PARAM_ERROR}")
			end
		end

	end

	describe '.validate_colour' do

		it 'should raise ArgumentError with no argument' do
			expect {BitmapUtils.validate_colour}.to raise_error(ArgumentError)
		end

		it 'should raise exception with wrong colour type' do
			expect {BitmapUtils.validate_colour('c')}.to raise_error(ArgumentError, 'Colour should be a single capital letter')
		end

		it 'should raise exception with wrong colour more than 1 character' do
			expect {BitmapUtils.validate_colour('CC')}.to raise_error(ArgumentError, 'Colour should be a single capital letter')
		end

		it 'should not raise exception with single capital letter' do
			expect {BitmapUtils.validate_colour('C')}.not_to raise_error
		end

	end
end
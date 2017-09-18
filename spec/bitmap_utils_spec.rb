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

	describe '.validate_size' do

		context 'With wrong arguments' do
			it 'should raise ArgumentError with no argument' do
				expect {BitmapUtils.validate_size}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with one argument' do
				expect {BitmapUtils.validate_size(1)}.to raise_error(ArgumentError)
			end

			it 'should raise exception with wrong size type' do
				expect {BitmapUtils.validate_size('1', 'Width')}.to raise_error(ArgumentError,"Width #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with zero size' do
				expect {BitmapUtils.validate_size(0,'Width')}.to raise_error(ArgumentError,"Width #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with size more than BitmapUtils::MAX_LENGTH' do
				expect {BitmapUtils.validate_size(BitmapUtils::MAX_LENGTH + 1,'Width')}.to raise_error(ArgumentError,"Width #{BitmapUtils::SIZE_PARAM_ERROR}")
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
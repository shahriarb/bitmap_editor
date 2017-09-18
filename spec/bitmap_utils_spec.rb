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

	describe '.validate_initials' do

		context 'With wrong arguments' do
			it 'should raise ArgumentError with no argument' do
				expect {BitmapUtils.validate_initials}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with one argument' do
				expect {BitmapUtils.validate_initials(1)}.to raise_error(ArgumentError)
			end

			it 'should raise exception with wrong width type' do
				expect {BitmapUtils.validate_initials('1',1)}.to raise_error(ArgumentError,"Width #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with zero width' do
				expect {BitmapUtils.validate_initials(0,1)}.to raise_error(ArgumentError,"Width #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with width more than BitmapUtils::MAX_LENGTH' do
				expect {BitmapUtils.validate_initials(BitmapUtils::MAX_LENGTH + 1,1)}.to raise_error(ArgumentError,"Width #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with wrong initial height type' do
				expect {BitmapUtils.validate_initials(1,'1')}.to raise_error(ArgumentError,"Height #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with zero height' do
				expect {BitmapUtils.validate_initials(1,0)}.to raise_error(ArgumentError,"Height #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with height more than BitmapUtils::MAX_LENGTH' do
				expect {BitmapUtils.validate_initials(1,BitmapUtils::MAX_LENGTH + 1)}.to raise_error(ArgumentError,"Height #{BitmapUtils::SIZE_PARAM_ERROR}")
			end
		end

	end

end
require 'colour_command'

describe ColourCommand do
	describe '#initilize' do
		context 'With wrong initial values' do
			it 'should raise ArgumentError with no initial argument' do
				expect {ColourCommand.new}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with one initial argument' do
				expect {ColourCommand.new(1)}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with two initial argument' do
				expect {ColourCommand.new(1, 1)}.to raise_error(ArgumentError)
			end

			it 'should raise exception with wrong initial X type' do
				expect {ColourCommand.new('1', 1, 'C')}.to raise_error(ArgumentError, "X #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with zero X' do
				expect {ColourCommand.new(0, 1, 'C')}.to raise_error(ArgumentError, "X #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with X more than BitmapUtils::MAX_LENGTH' do
				expect {ColourCommand.new(BitmapUtils::MAX_LENGTH + 1, 1, 'C')}.to raise_error(ArgumentError, "X #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with wrong initial Y type' do
				expect {ColourCommand.new(1, '1', 'C')}.to raise_error(ArgumentError, "Y #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with zero Y' do
				expect {ColourCommand.new(1, 0, 'C')}.to raise_error(ArgumentError, "Y #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with height more than BitmapUtils::MAX_LENGTH' do
				expect {ColourCommand.new(1, BitmapUtils::MAX_LENGTH + 1, 'C')}.to raise_error(ArgumentError, "Y #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with wrong colour type' do
				expect {ColourCommand.new(1, 1, 'c')}.to raise_error(ArgumentError, 'Colour should be a single capital letter')
			end

			it 'should raise exception with wrong colour more than 1 character' do
				expect {ColourCommand.new(1, 1, 'CC')}.to raise_error(ArgumentError, 'Colour should be a single capital letter')
			end


			context 'given 10 as x' do
				it 'x should be 10' do
					expect(ColourCommand.new(10, 1, 'C').x).to eq(10)
				end
			end

			context 'given 10 as y' do
				it 'y should be 10' do
					expect(ColourCommand.new(1, 10, 'C').y).to eq(10)
				end
			end

			context 'given C as colour' do
				it 'colour should be C' do
					expect(ColourCommand.new(1, 1, 'C').colour).to eq('C')
				end
			end
		end

	end

	describe '#execute' do
		before do
			@bitmap_colour_command = ColourCommand.new(10, 20, 'C')
		end

		it 'should accept one argument' do
			expect {@bitmap_colour_command.execute}.to raise_error(ArgumentError)
		end

		it 'should accept only one argument' do
			expect {@bitmap_colour_command.execute(nil,nil)}.to raise_error(ArgumentError)
		end

		it 'should return error if argument is not a valid bitmap' do
			_, _, error_message = @bitmap_colour_command.execute(nil)
			expect(error_message).to eq('This command needs a valid bitmap')
		end

		it 'should return error if width of bitmap is lass than X coordinate' do
			bitmap = Bitmap.new(1,1)
			_, _, error_message = @bitmap_colour_command.execute(bitmap)
			expect(error_message).to eq('X should be less than width(1)')
		end

		it 'should return error if height of bitmap is lass than Y coordinate' do
			bitmap = Bitmap.new(10,1)
			_, _, error_message = @bitmap_colour_command.execute(bitmap)
			expect(error_message).to eq('Y should be less than height(1)')
		end

		it 'should change the colour of x, y in bitmap to C with no output no error' do
			bitmap = Bitmap.new(20,40)
			expect(bitmap.get_colour(10, 20)).to eq(Bitmap::COLOUR_WHITE)

			result_bitmap, output_message, error_message = @bitmap_colour_command.execute(bitmap)

			expect(result_bitmap.get_colour(10, 20)).to eq('C')
			expect(error_message).to eq('')
			expect(output_message).to eq('')
		end

	end

end
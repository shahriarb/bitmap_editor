require 'hline_command'

describe HlineCommand do
	describe '#initilize' do
		context 'With wrong initial values' do
			it 'should raise ArgumentError with no initial argument' do
				expect {HlineCommand.new}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with one initial argument' do
				expect {HlineCommand.new(1)}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with two initial argument' do
				expect {HlineCommand.new(1, 1)}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with three initial argument' do
				expect {HlineCommand.new(1, 1, 2)}.to raise_error(ArgumentError)
			end

			it 'should raise exception with wrong initial X1 type' do
				expect {HlineCommand.new('1', 2, 2, 'C')}.to raise_error(ArgumentError, "X1 #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with zero X1' do
				expect {HlineCommand.new(0, 1, 2, 'C')}.to raise_error(ArgumentError, "X1 #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with X1 more than BitmapUtils::MAX_LENGTH' do
				expect {HlineCommand.new(BitmapUtils::MAX_LENGTH + 1, 1, 2, 'C')}.to raise_error(ArgumentError, "X1 #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with wrong initial X2 type' do
				expect {HlineCommand.new(1, '2', 2, 'C')}.to raise_error(ArgumentError, "X2 #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with zero X2' do
				expect {HlineCommand.new(1, 0, 2, 'C')}.to raise_error(ArgumentError, "X2 #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with X2 more than BitmapUtils::MAX_LENGTH' do
				expect {HlineCommand.new(1, BitmapUtils::MAX_LENGTH + 1, 2, 'C')}.to raise_error(ArgumentError, "X2 #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with wrong initial Y type' do
				expect {HlineCommand.new(1, 2, '2', 'C')}.to raise_error(ArgumentError, "Y #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with zero Y' do
				expect {HlineCommand.new(1, 2, 0, 'C')}.to raise_error(ArgumentError, "Y #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with Y more than BitmapUtils::MAX_LENGTH' do
				expect {HlineCommand.new(1, 2, BitmapUtils::MAX_LENGTH + 1, 'C')}.to raise_error(ArgumentError, "Y #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with wrong colour type' do
				expect {HlineCommand.new(1, 2, 2, 'c')}.to raise_error(ArgumentError, 'Colour should be a single capital letter')
			end

			it 'should raise exception with wrong colour more than 1 character' do
				expect {HlineCommand.new(1, 2, 2, 'CC')}.to raise_error(ArgumentError, 'Colour should be a single capital letter')
			end


			context 'given 10 as x1' do
				it 'x1 should be 10' do
					expect(HlineCommand.new(10, 20, 2, 'C').x1).to eq(10)
				end
			end

			context 'given 10 as x2' do
				it 'x2 should be 10' do
					expect(HlineCommand.new(1, 10, 20, 'C').x2).to eq(10)
				end
			end

			context 'given 20 as y' do
				it 'y should be 20' do
					expect(HlineCommand.new(1, 10, 20, 'C').y).to eq(20)
				end
			end

			context 'given C as colour' do
				it 'colour should be C' do
					expect(HlineCommand.new(1, 2, 2, 'C').colour).to eq('C')
				end
			end
		end

	end

	describe '#execute' do
		before do
			@hline_command = HlineCommand.new(10, 20, 30, 'C')
		end

		it 'should accept one argument' do
			expect {@hline_command.execute}.to raise_error(ArgumentError)
		end

		it 'should accept only one argument' do
			expect {@hline_command.execute(nil,nil)}.to raise_error(ArgumentError)
		end

		it 'should return error if argument is not a valid bitmap' do
			_, _, error_message = @hline_command.execute(nil)
			expect(error_message).to eq(Command::INVALID_BITMAP_ERROR)
		end

		it 'should return error if width of bitmap is lass than X1 coordinate' do
			bitmap = Bitmap.new(1,1)
			_, _, error_message = @hline_command.execute(bitmap)
			expect(error_message).to eq('X1 should be less than width(1)')
		end

		it 'should return error if width of bitmap is lass than X2 coordinate' do
			bitmap = Bitmap.new(10,1)
			_, _, error_message = @hline_command.execute(bitmap)
			expect(error_message).to eq('X2 should be less than width(10)')
		end

		it 'should return error if height of bitmap is lass than Y coordinate' do
			bitmap = Bitmap.new(20,20)
			_, _, error_message = @hline_command.execute(bitmap)
			expect(error_message).to eq('Y should be less than height(20)')
		end

		context 'given the x1 = 10 , x2 = 20 , y = 30, colour = C' do
			it 'should change the colour of all pixels with y = 30 and x between 10-20 to C with no output no error' do
				bitmap = Bitmap.new(20,40)
				10.upto(20) {|x| expect(bitmap.get_colour(x, 30)).to eq(Bitmap::COLOUR_WHITE)     }

				result_bitmap, output_message, error_message = @hline_command.execute(bitmap)

				10.upto(20) {|x| expect(result_bitmap.get_colour(x, 30)).to eq('C')     }

				expect(error_message).to eq('')
				expect(output_message).to eq('')
			end
		end


		context 'given the x1(20) greater than x2(10) should set colour for all pixels between x2 and x1 to C' do
			it 'should change the colour of all pixels with x between 20-30 to C with no output no error' do
				hline_command = HlineCommand.new(20, 10, 30, 'C')

				bitmap = Bitmap.new(20,40)
				10.upto(20) {|x| expect(bitmap.get_colour(x, 30)).to eq(Bitmap::COLOUR_WHITE) }

				result_bitmap, output_message, error_message = hline_command.execute(bitmap)

				10.upto(20) {|x| expect(result_bitmap.get_colour(x, 30)).to eq('C') }

				expect(error_message).to eq('')
				expect(output_message).to eq('')
			end
		end

	end

end
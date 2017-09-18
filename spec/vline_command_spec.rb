require 'vline_command'

describe VlineCommand do
	describe '#initilize' do
		context 'With wrong initial values' do
			it 'should raise ArgumentError with no initial argument' do
				expect {VlineCommand.new}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with one initial argument' do
				expect {VlineCommand.new(1)}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with two initial argument' do
				expect {VlineCommand.new(1, 1)}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with three initial argument' do
				expect {VlineCommand.new(1, 1, 2)}.to raise_error(ArgumentError)
			end

			it 'should raise exception with wrong initial X type' do
				expect {VlineCommand.new('1', 1, 2, 'C')}.to raise_error(ArgumentError, "X #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with zero X' do
				expect {VlineCommand.new(0, 1, 2, 'C')}.to raise_error(ArgumentError, "X #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with X more than BitmapUtils::MAX_LENGTH' do
				expect {VlineCommand.new(BitmapUtils::MAX_LENGTH + 1, 1, 2, 'C')}.to raise_error(ArgumentError, "X #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with wrong initial Y1 type' do
				expect {VlineCommand.new(1, '1', 2, 'C')}.to raise_error(ArgumentError, "Y1 #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with zero Y1' do
				expect {VlineCommand.new(1, 0, 2, 'C')}.to raise_error(ArgumentError, "Y1 #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with Y1 more than BitmapUtils::MAX_LENGTH' do
				expect {VlineCommand.new(1, BitmapUtils::MAX_LENGTH + 1, 2, 'C')}.to raise_error(ArgumentError, "Y1 #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with wrong initial Y2 type' do
				expect {VlineCommand.new(1, 1, '2', 'C')}.to raise_error(ArgumentError, "Y2 #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with zero Y2' do
				expect {VlineCommand.new(1, 1, 0, 'C')}.to raise_error(ArgumentError, "Y2 #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with Y2 more than BitmapUtils::MAX_LENGTH' do
				expect {VlineCommand.new(1, 1, BitmapUtils::MAX_LENGTH + 1, 'C')}.to raise_error(ArgumentError, "Y2 #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with wrong colour type' do
				expect {VlineCommand.new(1, 1, 2, 'c')}.to raise_error(ArgumentError, 'Colour should be a single capital letter')
			end

			it 'should raise exception with wrong colour more than 1 character' do
				expect {VlineCommand.new(1, 1, 2, 'CC')}.to raise_error(ArgumentError, 'Colour should be a single capital letter')
			end


			context 'given 10 as x' do
				it 'x should be 10' do
					expect(VlineCommand.new(10, 1, 2, 'C').x).to eq(10)
				end
			end

			context 'given 10 as y1' do
				it 'y1 should be 10' do
					expect(VlineCommand.new(1, 10, 20, 'C').y1).to eq(10)
				end
			end

			context 'given 20 as y2' do
				it 'y2 should be 20' do
					expect(VlineCommand.new(1, 10, 20, 'C').y2).to eq(20)
				end
			end

			context 'given C as colour' do
				it 'colour should be C' do
					expect(VlineCommand.new(1, 1, 2, 'C').colour).to eq('C')
				end
			end
		end

	end

	describe '#execute' do
		before do
			@vline_command = VlineCommand.new(10, 20, 30, 'C')
		end

		it 'should accept one argument' do
			expect {@vline_command.execute}.to raise_error(ArgumentError)
		end

		it 'should accept only one argument' do
			expect {@vline_command.execute(nil,nil)}.to raise_error(ArgumentError)
		end

		it 'should return error if argument is not a valid bitmap' do
			_, _, error_message = @vline_command.execute(nil)
			expect(error_message).to eq('This command needs a valid bitmap')
		end

		it 'should return error if width of bitmap is lass than X coordinate' do
			bitmap = Bitmap.new(1,1)
			_, _, error_message = @vline_command.execute(bitmap)
			expect(error_message).to eq('X should be less than width(1)')
		end

		it 'should return error if height of bitmap is lass than Y1 coordinate' do
			bitmap = Bitmap.new(10,1)
			_, _, error_message = @vline_command.execute(bitmap)
			expect(error_message).to eq('Y1 should be less than height(1)')
		end

		it 'should return error if height of bitmap is lass than Y2 coordinate' do
			bitmap = Bitmap.new(10,20)
			_, _, error_message = @vline_command.execute(bitmap)
			expect(error_message).to eq('Y2 should be less than height(20)')
		end

		context 'given the x = 10 , y1 = 20 , y2 = 30, colour = C' do
			it 'should change the colour of all pixels with x = 10 and y between 20-30 to C with no output no error' do
				bitmap = Bitmap.new(20,40)
				20.upto(30) {|y| expect(bitmap.get_colour(10, y)).to eq(Bitmap::COLOUR_WHITE)     }

				result_bitmap, output_message, error_message = @vline_command.execute(bitmap)

				20.upto(30) {|y| expect(result_bitmap.get_colour(10, y)).to eq('C')     }

				expect(error_message).to eq('')
				expect(output_message).to eq('')
			end
		end


		context 'given the y1(30) greater than y2(20) should set colour for all pixels between y2 and y1 to C' do
			it 'should change the colour of all pixels with y between 20-30 to C with no output no error' do
				vline_command = VlineCommand.new(10, 30, 20, 'C')

				bitmap = Bitmap.new(20,40)
				20.upto(30) {|y| expect(bitmap.get_colour(10, y)).to eq(Bitmap::COLOUR_WHITE)     }

				result_bitmap, output_message, error_message = vline_command.execute(bitmap)

				20.upto(30) {|y| expect(result_bitmap.get_colour(10, y)).to eq('C')     }

				expect(error_message).to eq('')
				expect(output_message).to eq('')
			end
		end

	end

end
require 'bitmap_initialize_command'

describe BitmapInitializeCommand do
	describe '#initilize' do
		context 'With wrong initial values' do
			it 'should raise ArgumentError with no initial argument' do
				expect {BitmapInitializeCommand.new}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with one initial argument' do
				expect {BitmapInitializeCommand.new(1)}.to raise_error(ArgumentError)
			end

			it 'should raise exception with wrong initial width type' do
				expect {BitmapInitializeCommand.new('1',1)}.to raise_error(ArgumentError,"Width #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with zero width' do
				expect {BitmapInitializeCommand.new(0,1)}.to raise_error(ArgumentError,"Width #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with width more than BitmapUtils::MAX_LENGTH' do
				expect {BitmapInitializeCommand.new(BitmapUtils::MAX_LENGTH + 1,1)}.to raise_error(ArgumentError,"Width #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with wrong initial height type' do
				expect {BitmapInitializeCommand.new(1,'1')}.to raise_error(ArgumentError,"Height #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with zero height' do
				expect {BitmapInitializeCommand.new(1,0)}.to raise_error(ArgumentError,"Height #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with height more than BitmapUtils::MAX_LENGTH' do
				expect {BitmapInitializeCommand.new(1,BitmapUtils::MAX_LENGTH + 1)}.to raise_error(ArgumentError,"Height #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			context 'given 10 as width' do
				it 'width should be 10' do
					expect(BitmapInitializeCommand.new(10,1).width).to eq(10)
				end
			end

			context 'given 10 as height' do
				it 'height should be 10' do
					expect(BitmapInitializeCommand.new(1,10).height).to eq(10)
				end
			end

		end

		describe '#execute' do
			before do
				@bitmap_initialize_command = BitmapInitializeCommand.new(10,20)
			end

			it 'should accept one argument' do
				expect {@bitmap_initialize_command.execute}.to raise_error(ArgumentError)
			end

			it 'should return a bitmap object with height and width specified in initialization' do
				bitmap, _, _ = @bitmap_initialize_command.execute(nil)

				expect(bitmap.width).to eq(10)
				expect(bitmap.height).to eq(20)
			end

			it 'should return empty string as output_message' do
				_, output_message, _ = @bitmap_initialize_command.execute(nil)

				expect(output_message).to eq('')
			end

			it 'should return empty string as error_message' do
				_, _, error_message = @bitmap_initialize_command.execute(nil)

				expect(error_message).to eq('')
			end

		end

	end
end
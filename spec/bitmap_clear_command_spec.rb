require 'bitmap_clear_command'

describe BitmapClearCommand do

	describe '#initilize' do
		context 'With wrong initial values' do
			it 'should raise ArgumentError if any argument passed' do
				expect {BitmapClearCommand.new(nil)}.to raise_error(ArgumentError)
			end
		end
	end

	describe '#execute' do
		before do
			@bitmap_clear_command = BitmapClearCommand.new
		end

		it 'should accept one argument' do
			expect {@bitmap_clear_command.execute}.to raise_error(ArgumentError)
		end

		it 'should accept only one argument' do
			expect {@bitmap_clear_command.execute(nil,nil)}.to raise_error(ArgumentError)
		end

		it 'should return error if argument is not a valid bitmap' do
			_, _, error_message = @bitmap_clear_command.execute(nil)
			expect(error_message).to eq('This command needs a valid bitmap')
		end

		it 'should clear the passed bitmap with no output no error' do
			bitmap = Bitmap.new(10,20)
			expect(bitmap.pixels.all? {|row| row.all? {|pixel| pixel == Bitmap::COLOUR_WHITE}}).to be true
			bitmap.set_colour(1,1,'C')
			expect(bitmap.pixels.all? {|row| row.all? {|pixel| pixel == Bitmap::COLOUR_WHITE}}).to_not be true

			result_bitmap , output_message, error_message = @bitmap_clear_command.execute(bitmap)
			expect(result_bitmap.pixels.all? {|row| row.all? {|pixel| pixel == Bitmap::COLOUR_WHITE}}).to be true
			expect(error_message).to eq('')
			expect(output_message).to eq('')
		end
	end
end
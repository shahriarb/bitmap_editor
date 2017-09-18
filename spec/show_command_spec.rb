require 'show_command'

describe ShowCommand do

	describe '#initilize' do
		context 'With wrong initial values' do
			it 'should raise ArgumentError if any argument passed' do
				expect {ShowCommand.new(nil)}.to raise_error(ArgumentError)
			end
		end
	end

	describe '#execute' do
		before do
			@show_command = ShowCommand.new
		end

		it 'should accept one argument' do
			expect {@show_command.execute}.to raise_error(ArgumentError)
		end

		it 'should accept only one argument' do
			expect {@show_command.execute(nil,nil)}.to raise_error(ArgumentError)
		end

		it 'should return error if argument is not a valid bitmap' do
			_, _, error_message = @show_command.execute(nil)
			expect(error_message).to eq('This command needs a valid bitmap')
		end

		it 'should return the passed bitmap.to_s with no error' do
			bitmap = Bitmap.new(2,3)
			result_bitmap , output_message, error_message = @show_command.execute(bitmap)
			expect(output_message).to eq("OO\nOO\nOO")
			expect(error_message).to eq('')

			result_bitmap.set_colour(1,1,'C')
			_, output_message, error_message = @show_command.execute(bitmap)
			expect(output_message).to eq("CO\nOO\nOO")
			expect(error_message).to eq('')
		end
	end
end
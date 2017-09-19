require 'input_handler'

describe InputHandler do
	describe '.parse_line' do
		it 'should accept one argument' do
			expect {InputHandler.parse_line}.to raise_error(ArgumentError)
		end

		it 'should accept only one argument' do
			expect {InputHandler.parse_line(nil,nil)}.to raise_error(ArgumentError)
		end

		context 'given nil as argument' do
			it 'should raise exception' do
				expect {InputHandler.parse_line(nil)}.to raise_error(ArgumentError,'Input line can not be empty')
			end
		end

		context 'given empty string as argument' do
			it 'should raise exception' do
				expect {InputHandler.parse_line('')}.to raise_error(ArgumentError,'Input line can not be empty')
			end
		end

		context 'given I as argument' do
			it 'should return an :initilize command with empty params' do
				expect(InputHandler.parse_line'I').to eq({:command => :initialize, :params => []})
			end
		end

		context 'given C as argument' do
			it 'should return an :clear command with empty params' do
				expect(InputHandler.parse_line'C').to eq({:command => :clear, :params => []})
			end
		end

		context 'given L X Y C as argument' do
			it 'should return an :colour command with [X,Y,C] params' do
				expect(InputHandler.parse_line'L X Y C').to eq({:command => :colour, :params => ['X', 'Y', 'C']})
			end
		end

		context 'given V X Y1 Y2 C as argument' do
			it 'should return an :vline command with [X,Y1,Y2,C] params' do
				expect(InputHandler.parse_line'V X Y1 Y2 C').to eq({:command => :vline, :params => ['X','Y1','Y2','C']})
			end
		end

		context 'given H X1 X2 Y C as argument' do
			it 'should return an :hline command with [X1,X2,Y,C] params' do
				expect(InputHandler.parse_line'H X1 X2 Y C').to eq({:command => :hline, :params => ['X1','X2','Y','C']})
			end
		end

		context 'given S as argument' do
			it 'should return an :show command with empty params' do
				expect(InputHandler.parse_line'S').to eq({:command => :show, :params => []})
			end
		end

		context 'given a line starts with an invalid abbreviation' do
			it 'should raise an exception' do
				expect {InputHandler.parse_line('mike is 10')}.to raise_error(ArgumentError,CommandFactory::INVALID_ABBR)
			end
		end

		context 'given more parameter than a command needs' do
			it 'should not raise error' do
				expect {InputHandler.parse_line('I X')}.to_not raise_error
				expect {InputHandler.parse_line('C X')}.to_not raise_error
				expect {InputHandler.parse_line('L X Y C X')}.to_not raise_error
				expect {InputHandler.parse_line('V X Y1 Y2 C X')}.to_not raise_error
				expect {InputHandler.parse_line('H X1 X2 Y C X')}.to_not raise_error
				expect {InputHandler.parse_line('S X')}.to_not raise_error
			end
		end

		context 'given less parameter than a command needs' do
			it 'should not raise error' do
				expect {InputHandler.parse_line('L X Y')}.to_not raise_error
				expect {InputHandler.parse_line('V X Y1 Y2')}.to_not raise_error
				expect {InputHandler.parse_line('H X1 X2 Y')}.to_not raise_error
			end
		end

		context 'given an input starting with spaces' do
			it 'should strip the spaces' do
				expect(InputHandler.parse_line'    L X Y C').to eq({:command => :colour, :params => ['X', 'Y', 'C']})
			end
		end

		context 'given an input ending with spaces' do
			it 'should strip the spaces' do
				expect(InputHandler.parse_line'L X Y C    ').to eq({:command => :colour, :params => ['X', 'Y', 'C']})
			end
		end
	end

	describe '.load_from_file' do
		it 'should accept one argument' do
			expect {InputHandler.load_from_file}.to raise_error(ArgumentError)
		end

		it 'should accept only one argument' do
			expect {InputHandler.load_from_file(nil,nil)}.to raise_error(ArgumentError)
		end

		it 'should raise an exception if file dose not exist' do
			_, errors = InputHandler.load_from_file('not_exist.txt')
			expect(errors.first).to eq('please provide correct file')
		end

		context 'given a valid file' do
			it 'should return list of commands and their parameters with no error for a single line file' do
				commands, errors = InputHandler.load_from_file('examples/show.txt')
				expect(commands.size).to be 1
				expect(commands.first).to eq({:command => :show, :params => []})
				expect(errors).to eq([])
			end

			it 'should return list of commands and their parameters with no error for a multi line file' do
				commands, errors = InputHandler.load_from_file('examples/init_show.txt')
				expect(commands.size).to be 2
				expect(commands.first).to eq({:command => :initialize, :params => ['2', '3']})
				expect(commands.last).to eq({:command => :show, :params => []})
				expect(errors).to eq([])
			end
		end

		context 'given an invalid file' do
			context 'given a file with wrong abbreviation' do
				it 'should return error with line number' do
					_, errors = InputHandler.load_from_file('examples/wrong_abbr.txt')
					expect(errors.size).to be 2
					expect(errors.first).to eq("Error line(1):\n#{CommandFactory::INVALID_ABBR}")
					expect(errors.last).to eq("Error line(2):\n#{CommandFactory::INVALID_ABBR}")
				end
			end

			context 'given an empty file' do
				it 'should return error an empty line error' do
					_, errors = InputHandler.load_from_file('examples/empty.txt')
					expect(errors.first).to eq("Error line(1):\nInput line can not be empty")
				end
			end
		end

	end
end
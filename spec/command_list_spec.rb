require 'command_list'
require 'initialize_command'
require 'colour_command'

describe CommandList do
	describe '#initilize' do
		it 'should have an empty list of command' do
			expect(CommandList.new.commands).to eq([])
		end

		it 'should have a nil bitmap' do
			expect(CommandList.new.bitmap).to be_nil
		end
	end

	describe '#add_command'  do
		before do
			@command_list = CommandList.new
		end

		it 'should accept one argument' do
			expect {@command_list.add_command}.to raise_error(ArgumentError)
		end

		it 'should accept only one argument' do
			expect {@command_list.add_command(nil,nil)}.to raise_error(ArgumentError)
		end

		it 'should raise exception if argument is not a valid command' do
			expect {@command_list.add_command(nil)}.to raise_error(ArgumentError,'Command is not valid')
		end

		it 'should add command to command_list.commands' do
			expect(@command_list.commands.size).to be 0
			new_command = InitializeCommand.new(1,1)
			@command_list.add_command(new_command)
			expect(@command_list.commands.size).to be 1
			expect(@command_list.commands.first).to be new_command
		end
	end

	describe '#execute' do
		before do
			@command_list = CommandList.new
		end

		it 'should accept one argument' do
			expect {@command_list.execute}.to raise_error(ArgumentError)
		end

		it 'should accept only one argument' do
			expect {@command_list.execute(nil,nil)}.to raise_error(ArgumentError)
		end

		it 'should not raise error with no command' do
			expect {@command_list.execute(nil)}.to_not raise_error
		end

		it 'should return a bitmap as result of running command' do
			init_command = InitializeCommand.new(10,20)
			@command_list.add_command(init_command)
			colour_command = ColourCommand.new(1,1,'C')
			@command_list.add_command(colour_command)
			result_bitmap, output_message, error_message = @command_list.execute(nil)
			expect(result_bitmap.width).to eq(10)
			expect(result_bitmap.height).to eq(20)
			expect(result_bitmap.get_colour(1,1)).to eq('C')
			expect(output_message).to eq('')
			expect(error_message).to eq('')
		end

		it 'should not execute all list if an error happened for one command' do
			colour_command = ColourCommand.new(1,1,'C')
			@command_list.add_command(colour_command)

			init_command = InitializeCommand.new(10,20)
			@command_list.add_command(init_command)
			result_bitmap, output_message, error_message = @command_list.execute(nil)

			expect(result_bitmap).to be_nil
			expect(output_message).to eq('')
			expect(error_message).to eq("Error line(1):\t#{Command::INVALID_BITMAP_ERROR}")
		end

		it 'should return the result of execute as the output' do
			init_command = InitializeCommand.new(2,3)
			@command_list.add_command(init_command)
			colour_command = ColourCommand.new(1,1,'C')
			@command_list.add_command(colour_command)
			show_command = ShowCommand.new
			@command_list.add_command(show_command)
			result_bitmap, output_message, error_message = @command_list.execute(nil)
			expect(result_bitmap.width).to eq(2)
			expect(result_bitmap.height).to eq(3)
			expect(result_bitmap.get_colour(1,1)).to eq('C')
			expect(output_message).to eq("CO\nOO\nOO")
			expect(error_message).to eq('')
		end
	end
end
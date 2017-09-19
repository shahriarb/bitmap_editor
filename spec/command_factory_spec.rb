require 'command_factory'

describe CommandFactory do

	context 'testing constraints' do
		it 'has a constant array called VALID_COMMANDS' do
			expect(CommandFactory::VALID_COMMANDS).to be_instance_of(Array)
		end

		it 'VALID_COMMANDS should contain initialize' do
			expect(CommandFactory::VALID_COMMANDS).to include(:initialize)
		end

		it 'VALID_COMMANDS should contain clear' do
			expect(CommandFactory::VALID_COMMANDS).to include(:clear)
		end

		it 'VALID_COMMANDS should contain colour' do
			expect(CommandFactory::VALID_COMMANDS).to include(:colour)
		end

		it 'VALID_COMMANDS should contain vline' do
			expect(CommandFactory::VALID_COMMANDS).to include(:vline)
		end

		it 'VALID_COMMANDS should contain hline' do
			expect(CommandFactory::VALID_COMMANDS).to include(:hline)
		end

		it 'VALID_COMMANDS should contain show' do
			expect(CommandFactory::VALID_COMMANDS).to include(:show)
		end

		it 'has a constant Hash called COMMANDS_ABBR' do
			expect(CommandFactory::COMMANDS_ABBR).to be_instance_of(Hash)
		end

		it 'COMMANDS_ABBR should contain all VALID_COMMANDS' do
			CommandFactory::VALID_COMMANDS.each do |command|
				expect(CommandFactory::COMMANDS_ABBR.keys).to include(command)
			end
		end

		it 'COMMAND_ABBR[:initialize] value should be I' do
			expect(CommandFactory::COMMANDS_ABBR[:initialize]).to eq('I')
		end

		it 'COMMAND_ABBR[:clear] value should be C' do
			expect(CommandFactory::COMMANDS_ABBR[:clear]).to eq('C')
		end

		it 'COMMAND_ABBR[:colour] value should be L' do
			expect(CommandFactory::COMMANDS_ABBR[:colour]).to eq('L')
		end

		it 'COMMAND_ABBR[:vline] value should be V' do
			expect(CommandFactory::COMMANDS_ABBR[:vline]).to eq('V')
		end

		it 'COMMAND_ABBR[:hline] value should be H' do
			expect(CommandFactory::COMMANDS_ABBR[:hline]).to eq('H')
		end

		it 'COMMAND_ABBR[:show] value should be S' do
			expect(CommandFactory::COMMANDS_ABBR[:show]).to eq('S')
		end

		it 'has a constant called INVALID_ABBR' do
			expect(CommandFactory::INVALID_ABBR).to eq('unrecognised command')
		end

		it 'has a constant called INVALID_COMMAND' do
			expect(CommandFactory::INVALID_COMMAND).to eq('command is not valid')
		end
	end

	describe '.abbr_to_command' do
		it 'should accept one argument' do
			expect {CommandFactory.abbr_to_command}.to raise_error(ArgumentError)
		end

		it 'should accept only one argument' do
			expect {CommandFactory.abbr_to_command(nil,nil)}.to raise_error(ArgumentError)
		end

		context 'given nil as abbreviation' do
			it 'should raise an exception' do
				expect {CommandFactory.abbr_to_command(nil)}.to raise_error(ArgumentError,CommandFactory::INVALID_ABBR)
			end
		end

		context 'given I as abbreviation' do
			it 'should return :initialize' do
				expect(CommandFactory.abbr_to_command('I')).to be :initialize
			end
		end

		context 'given C as abbreviation' do
			it 'should return :clear' do
				expect(CommandFactory.abbr_to_command('C')).to be :clear
			end
		end

		context 'given L as abbreviation' do
			it 'should return :colour' do
				expect(CommandFactory.abbr_to_command('L')).to be :colour
			end
		end

		context 'given V as abbreviation' do
			it 'should return :vline' do
				expect(CommandFactory.abbr_to_command('V')).to be :vline
			end
		end

		context 'given H as abbreviation' do
			it 'should return :hline' do
				expect(CommandFactory.abbr_to_command('H')).to be :hline
			end
		end

		context 'given S as abbreviation' do
			it 'should return :show' do
				expect(CommandFactory.abbr_to_command('S')).to be :show
			end
		end

		context 'given an invalid abbreviation' do
			it 'should raise an exception' do
				expect {CommandFactory.abbr_to_command('M')}.to raise_error(ArgumentError,CommandFactory::INVALID_ABBR)
			end
		end
	end

	describe '.create' do
		it 'should have at least one argument' do
			expect {CommandFactory.create}.to raise_error(ArgumentError)
		end

		context 'given an invalid command' do
			it 'should raise an exception' do
				expect {CommandFactory.create(:some_command)}.to raise_error(ArgumentError,CommandFactory::INVALID_COMMAND)
			end
		end

		context 'given :initialize as command' do
			context 'given width=10 height=20' do
				it 'should return InitializeCommand with correct attribute' do
					result_command = CommandFactory.create(:initialize,10,20)
					expect(result_command).to be_instance_of(InitializeCommand)
					expect(result_command.width).to eq(10)
					expect(result_command.height).to eq(20)
				end
			end

			context 'given width=10 height=20 in string format' do
				it 'should return InitializeCommand with correct attribute' do
					result_command = CommandFactory.create(:initialize,'10','20')
					expect(result_command).to be_instance_of(InitializeCommand)
					expect(result_command.width).to eq(10)
					expect(result_command.height).to eq(20)
				end
			end

			context 'given wrong attributes' do
				it 'should raise a proper exception' do
					expect { CommandFactory.create(:initialize,0,20) }.to raise_error(ArgumentError, "Width #{BitmapUtils::SIZE_PARAM_ERROR}")
				end
			end
		end


		context 'given :clear as command' do
			context 'no argument' do
				it 'should return ClearCommand' do
					expect(CommandFactory.create(:clear)).to be_instance_of(ClearCommand)
				end
			end
		end

		context 'given :colour as command' do
			context 'given width=10 height=20 colour C' do
				it 'should return ColourCommand with correct attribute' do
					result_command = CommandFactory.create(:colour,10,20, 'C')
					expect(result_command).to be_instance_of(ColourCommand)
					expect(result_command.x).to eq(10)
					expect(result_command.y).to eq(20)
					expect(result_command.colour).to eq('C')
				end
			end

			context 'given width=10 height=20 in string format' do
				it 'should return ColourCommand with correct attribute' do
					result_command = CommandFactory.create(:colour,'10','20', 'C')
					expect(result_command).to be_instance_of(ColourCommand)
					expect(result_command.x).to eq(10)
					expect(result_command.y).to eq(20)
				end
			end

			context 'given wrong attributes' do
				it 'should raise a proper exception' do
					expect { CommandFactory.create(:colour,0,20,'C') }.to raise_error(ArgumentError, "X #{BitmapUtils::SIZE_PARAM_ERROR}")
				end
			end
		end

		context 'given :vline as command' do
			context 'given x=10 y1=5 y2=15 colour C' do
				it 'should return VlineCommand with correct attribute' do
					result_command = CommandFactory.create(:vline,10, 5, 15, 'C')
					expect(result_command).to be_instance_of(VlineCommand)
					expect(result_command.x).to eq(10)
					expect(result_command.y1).to eq(5)
					expect(result_command.y2).to eq(15)
					expect(result_command.colour).to eq('C')
				end
			end

			context 'given x=10 y1=5 y2=15 in string format' do
				it 'should return VlineCommand with correct attribute' do
					result_command = CommandFactory.create(:vline,'10', '5', '15', 'C')
					expect(result_command).to be_instance_of(VlineCommand)
					expect(result_command.x).to eq(10)
					expect(result_command.y1).to eq(5)
					expect(result_command.y2).to eq(15)
				end
			end

			context 'given wrong attributes' do
				it 'should raise a proper exception' do
					expect { CommandFactory.create(:vline,0, 20, 30, 'C') }.to raise_error(ArgumentError, "X #{BitmapUtils::SIZE_PARAM_ERROR}")
				end
			end
		end

		context 'given :hline as command' do
			context 'given x1=10 x2=15 y=5 colour C' do
				it 'should return HlineCommand with correct attribute' do
					result_command = CommandFactory.create(:hline,10, 15, 5, 'C')
					expect(result_command).to be_instance_of(HlineCommand)
					expect(result_command.x1).to eq(10)
					expect(result_command.x2).to eq(15)
					expect(result_command.y).to eq(5)
					expect(result_command.colour).to eq('C')
				end
			end

			context 'given x1=10 x2=15 y=5 colour C in string format' do
				it 'should return HlineCommand with correct attribute' do
					result_command = CommandFactory.create(:hline,'10', '15', '5', 'C')
					expect(result_command).to be_instance_of(HlineCommand)
					expect(result_command.x1).to eq(10)
					expect(result_command.x2).to eq(15)
					expect(result_command.y).to eq(5)
				end
			end

			context 'given wrong attributes' do
				it 'should raise a proper exception' do
					expect { CommandFactory.create(:hline,0, 20, 30, 'C') }.to raise_error(ArgumentError, "X1 #{BitmapUtils::SIZE_PARAM_ERROR}")
				end
			end
		end

		context 'given :show as command' do
			context 'no argument' do
				it 'should return ShowCommand' do
					expect(CommandFactory.create(:show)).to be_instance_of(ShowCommand)
				end
			end
		end

	end

end
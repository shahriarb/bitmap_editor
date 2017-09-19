require 'bitmap_editor'

describe BitmapEditor do
	describe '#run' do
		it 'should accept one argument' do
			expect {BitmapEditor.new.run}.to raise_error(ArgumentError)
		end

		it 'should accept only one argument' do
			expect {BitmapEditor.new.run(nil,nil)}.to raise_error(ArgumentError)
		end

		context 'given a file which does not exist' do
			it 'should write error to stdout' do
				expect { BitmapEditor.new.run('not_exist.txt') }.to output("please provide correct file\n").to_stdout
			end
		end

		context 'given an invalid file' do
			context 'given an empty file' do
				it 'should write error to stdout' do
					expect { BitmapEditor.new.run('examples/empty.txt') }.to output("Error line(1):\nInput line can not be empty\n").to_stdout
				end
			end

			context 'given a file with wrong abbreviation' do
				it 'should return error with line number' do
					expect { BitmapEditor.new.run('examples/wrong_abbr.txt') }.to output("Error line(1):\n#{CommandFactory::INVALID_ABBR}\nError line(2):\n#{CommandFactory::INVALID_ABBR}\n").to_stdout
				end
			end

			context 'given a file with correct command and wrong parameters' do
				it 'should return error with line number' do
					expect { BitmapEditor.new.run('examples/wrong_param.txt') }.to output("Error line(1):\nHeight should be a valid integer between 1 and 250\nError line(3):\nX #{BitmapUtils::SIZE_PARAM_ERROR}\n").to_stdout
				end
			end

			context 'given a file with :show before :initialize' do
				it 'should return error with line number' do
					expect { BitmapEditor.new.run('examples/show.txt') }.to output("Error line(1):\nThere is no image\n").to_stdout
				end
			end
		end
	end
end
require 'bitmap'

describe Bitmap do

	it 'has a COLOR_WHITE constant with value O' do
		expect(Bitmap::COLOUR_WHITE).to eq('O')
	end

	describe '#initialize' do
		context  'With wrong initial values' do
			it 'should raise ArgumentError with no initial argument' do
				expect {Bitmap.new}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with one initial argument' do
				expect {Bitmap.new(0)}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with one initial argument' do
				expect {Bitmap.new(0)}.to raise_error(ArgumentError)
			end

			it 'should raise exception with wrong initial width type' do
				expect {Bitmap.new('0',0)}.to raise_error('Width should be a valid integer')
			end

			it 'should raise exception with wrong initial height type' do
				expect {Bitmap.new(0,'0')}.to raise_error('Height should be a valid integer')
			end

			it 'should raise exception with negative width' do
				expect {Bitmap.new(-1,0)}.to raise_error('Width should be a positive integer')
			end

			it 'should raise exception with width more than 250' do
				expect {Bitmap.new(251,0)}.to raise_error('Width should be less than 250')
			end

			it 'should raise exception with negative height' do
				expect {Bitmap.new(0,-1)}.to raise_error('Height should be a positive integer')
			end

			it 'should raise exception with height more than 250' do
				expect {Bitmap.new(0,251)}.to raise_error('Height should be less than 250')
			end

		end

		context 'given 10 as width' do
			it 'width should be 10' do
				expect(Bitmap.new(10,0).width).to eq(10)
			end
		end

		context 'given 10 as height' do
			it 'height should be 10' do
				expect(Bitmap.new(0,10).height).to eq(10)
			end
		end

		context 'given 0 as width and 0 as height' do
			it 'should have an empty array as pixels' do
				expect(Bitmap.new(0,0).pixels).to eq([])
			end
		end

		context 'given 10 as width and 20 as height' do
			before do
				@bitmap = Bitmap.new(10,20)
			end

			it 'should have a two dimensional array as pixels with 20 rows' do
				expect(@bitmap.pixels.size).to eq(20)
			end

			it 'should have a two dimensional array as pixels with 10 columns' do
				expect(@bitmap.pixels.all? {|row| row.size == 10}).to be true
			end

			it 'should have a 10*20 two dimensional array as pixels all of them contains Bitmap::COLOR_WHITE' do
				expect(@bitmap.pixels.all? {|row| row.all? {|pixel| pixel == Bitmap::COLOUR_WHITE} }).to be true
			end

		end

	end

	describe '#to_s' do
		context 'given 0 as width and 0 as height' do
			it 'should be empty string'do
				expect(Bitmap.new(0,0).to_s).to eq('')
			end
		end

		context 'given 2 as width and 2 as height' do
			it 'should return OO\nOO' do
				expect(Bitmap.new(2,2).to_s).to eq("OO\nOO")
			end
		end
	end

	describe '#set_colour' do

		context  'With wrong arguments' do
			it 'should raise ArgumentError with no arguments' do
				expect {Bitmap.new(10,20).set_colour}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with one arguments' do
				expect {Bitmap.new(10,20).set_colour(1)}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with two arguments' do
				expect {Bitmap.new(10,20).set_colour(1,1)}.to raise_error(ArgumentError)
			end

			it 'should raise exception with wrong X type' do
				expect {Bitmap.new(10,20).set_colour('1',1, 'C')}.to raise_error('X should be a valid integer')
			end

			it 'should raise exception with wrong Y type' do
				expect {Bitmap.new(10,20).set_colour(1,'1', 'C')}.to raise_error('Y should be a valid integer')
			end

			it 'should raise exception with wrong colour type' do
				expect {Bitmap.new(10,20).set_colour(1,1, 'c')}.to raise_error('Colour should be a single capital letter')
			end

			it 'should raise exception with wrong colour more than 1 character' do
				expect {Bitmap.new(10,20).set_colour(1,1, 'CC')}.to raise_error('Colour should be a single capital letter')
			end
		end

		context 'given x coordinate less than 1' do
			it 'should raise exception' do
				expect { Bitmap.new(10,20).set_colour(0,1,'C')}.to raise_error('X coordinate should be between 1 and 250')
			end
		end

		context 'given x coordinate greater than 250' do
			it 'should raise exception' do
				expect { Bitmap.new(10,20).set_colour(251,1,'C')}.to raise_error('X coordinate should be between 1 and 250')
			end
		end

		context 'given x coordinate greater than width' do
			it 'should raise exception' do
				expect { Bitmap.new(10,20).set_colour(20,1,'C')}.to raise_error('X coordinate should be less than width(10)')
			end
		end

		context 'given y coordinate less than 1' do
			it 'should raise exception' do
				expect { Bitmap.new(10,20).set_colour(1,0,'C')}.to raise_error('Y coordinate should be between 1 and 250')
			end
		end

		context 'given Y coordinate greater than 250' do
			it 'should raise exception' do
				expect { Bitmap.new(10,20).set_colour(1,251,'C')}.to raise_error('Y coordinate should be between 1 and 250')
			end
		end

		context 'given y coordinate greater than height' do
			it 'should raise exception' do
				expect { Bitmap.new(10,10).set_colour(1,20,'C')}.to raise_error('Y coordinate should be less than height(10)')
			end
		end

		context 'given x = 1 and y = 2 and colour C' do
			it 'should set the colour of pixels[1,0] to C' do
				bitmap = Bitmap.new(10,10)
				expect(bitmap.pixels[1][0]).to eq(Bitmap::COLOUR_WHITE)
				bitmap.set_colour(1,2,'C')
				expect(bitmap.pixels[1][0]).to eq('C')
			end
		end

	end

end
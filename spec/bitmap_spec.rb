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
				expect {Bitmap.new(1)}.to raise_error(ArgumentError)
			end

			it 'should raise exception with wrong initial width type' do
				expect {Bitmap.new('1',1)}.to raise_error(ArgumentError,"Width #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with zero width' do
				expect {Bitmap.new(0,1)}.to raise_error(ArgumentError,"Width #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with width more than BitmapUtils::MAX_LENGTH' do
				expect {Bitmap.new(BitmapUtils::MAX_LENGTH + 1,1)}.to raise_error(ArgumentError,"Width #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with wrong initial height type' do
				expect {Bitmap.new(1,'1')}.to raise_error(ArgumentError,"Height #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with zero height' do
				expect {Bitmap.new(1,0)}.to raise_error(ArgumentError,"Height #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with height more than BitmapUtils::MAX_LENGTH' do
				expect {Bitmap.new(1,BitmapUtils::MAX_LENGTH + 1)}.to raise_error(ArgumentError,"Height #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

		end

		context 'given 10 as width' do
			it 'width should be 10' do
				expect(Bitmap.new(10,1).width).to eq(10)
			end
		end

		context 'given 10 as height' do
			it 'height should be 10' do
				expect(Bitmap.new(1,10).height).to eq(10)
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
				expect {Bitmap.new(10,20).set_colour('1',1, 'C')}.to raise_error(ArgumentError, "X #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with wrong Y type' do
				expect {Bitmap.new(10,20).set_colour(1,'1', 'C')}.to raise_error(ArgumentError, "Y #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with wrong colour type' do
				expect {Bitmap.new(10,20).set_colour(1,1, 'c')}.to raise_error(ArgumentError, 'Colour should be a single capital letter')
			end

			it 'should raise exception with wrong colour more than 1 character' do
				expect {Bitmap.new(10,20).set_colour(1,1, 'CC')}.to raise_error(ArgumentError, 'Colour should be a single capital letter')
			end
		end

		context 'given x coordinate less than 1' do
			it 'should raise exception' do
				expect { Bitmap.new(10,20).set_colour(0,1,'C')}.to raise_error(ArgumentError, "X #{BitmapUtils::SIZE_PARAM_ERROR}")
			end
		end

		context 'given x coordinate greater than BitmapUtils::MAX_LENGTH' do
			it 'should raise exception' do
				expect { Bitmap.new(10,20).set_colour(BitmapUtils::MAX_LENGTH + 1,1,'C')}.to raise_error(ArgumentError, "X #{BitmapUtils::SIZE_PARAM_ERROR}")
			end
		end

		context 'given x coordinate greater than width' do
			it 'should raise exception' do
				expect { Bitmap.new(10,20).set_colour(20,1,'C')}.to raise_error(ArgumentError, 'X should be less than width(10)')
			end
		end

		context 'given y coordinate less than 1' do
			it 'should raise exception' do
				expect { Bitmap.new(10,20).set_colour(1,0,'C')}.to raise_error(ArgumentError, "Y #{BitmapUtils::SIZE_PARAM_ERROR}")
			end
		end

		context 'given Y coordinate greater than BitmapUtils::MAX_LENGTH' do
			it 'should raise exception' do
				expect { Bitmap.new(10,20).set_colour(1,BitmapUtils::MAX_LENGTH + 1,'C')}.to raise_error(ArgumentError, "Y #{BitmapUtils::SIZE_PARAM_ERROR}")
			end
		end

		context 'given y coordinate greater than height' do
			it 'should raise exception' do
				expect { Bitmap.new(10,10).set_colour(1,20,'C')}.to raise_error(ArgumentError, 'Y should be less than height(10)')
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

	describe '#get_color' do
		context  'With wrong arguments' do
			it 'should raise ArgumentError with no arguments' do
				expect {Bitmap.new(10,20).get_colour}.to raise_error(ArgumentError)
			end

			it 'should raise ArgumentError with one arguments' do
				expect {Bitmap.new(10,20).get_colour(1)}.to raise_error(ArgumentError)
			end

			it 'should raise exception with wrong X type' do
				expect {Bitmap.new(10,20).get_colour('1',1)}.to raise_error(ArgumentError, "X #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

			it 'should raise exception with wrong Y type' do
				expect {Bitmap.new(10,20).get_colour(1,'1')}.to raise_error(ArgumentError, "Y #{BitmapUtils::SIZE_PARAM_ERROR}")
			end

		end

		context 'given x coordinate less than 1' do
			it 'should raise exception' do
				expect { Bitmap.new(10,20).get_colour(0,1)}.to raise_error(ArgumentError, "X #{BitmapUtils::SIZE_PARAM_ERROR}")
			end
		end

		context 'given x coordinate greater than BitmapUtils::MAX_LENGTH' do
			it 'should raise exception' do
				expect { Bitmap.new(10,20).get_colour(BitmapUtils::MAX_LENGTH + 1,1)}.to raise_error(ArgumentError, "X #{BitmapUtils::SIZE_PARAM_ERROR}")
			end
		end

		context 'given x coordinate greater than width' do
			it 'should raise exception' do
				expect { Bitmap.new(10,20).get_colour(20,1)}.to raise_error(ArgumentError, 'X should be less than width(10)')
			end
		end

		context 'given y coordinate less than 1' do
			it 'should raise exception' do
				expect { Bitmap.new(10,20).get_colour(1,0)}.to raise_error(ArgumentError, "Y #{BitmapUtils::SIZE_PARAM_ERROR}")
			end
		end

		context 'given Y coordinate greater than BitmapUtils::MAX_LENGTH' do
			it 'should raise exception' do
				expect { Bitmap.new(10,20).get_colour(1,BitmapUtils::MAX_LENGTH + 1)}.to raise_error(ArgumentError, "Y #{BitmapUtils::SIZE_PARAM_ERROR}")
			end
		end

		context 'given y coordinate greater than height' do
			it 'should raise exception' do
				expect { Bitmap.new(10,10).get_colour(1,20)}.to raise_error(ArgumentError, 'Y should be less than height(10)')
			end
		end

		context 'set colour of x = 1 and y = 2 to colour C' do
			it 'should return C as colour of x = 1 and y = 2' do
				bitmap = Bitmap.new(10,10)
				expect(bitmap.get_colour(1,2)).to eq(Bitmap::COLOUR_WHITE)
				bitmap.set_colour(1,2,'C')
				expect(bitmap.get_colour(1,2)).to eq('C')
			end
		end
	end

	describe '#clear' do
		it 'should set all pixels to COLOUR_WHITE' do
			bitmap = Bitmap.new(10,20)
			expect(bitmap.pixels.all? {|row| row.all? {|pixel| pixel == Bitmap::COLOUR_WHITE}}).to be true
			bitmap.set_colour(1,1,'C')
			expect(bitmap.pixels.all? {|row| row.all? {|pixel| pixel == Bitmap::COLOUR_WHITE}}).to_not be true
			bitmap.clear
			expect(bitmap.pixels.all? {|row| row.all? {|pixel| pixel == Bitmap::COLOUR_WHITE}}).to be true
		end
	end

end
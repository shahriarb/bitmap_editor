require 'bitmap_utils'

class Bitmap
	attr_reader :width, :height,:pixels

	COLOUR_WHITE = 'O'

	def initialize(new_width, new_height)
		BitmapUtils.validate_sizes(new_width, 'Width', new_height, 'Height')
		@width = new_width
		@height = new_height
		self.clear
	end

	def to_s
		@pixels.inject('') {|result,row|  result + "#{row.join}\n" }.strip
	end

	def set_colour(x,y,new_colour)
		validate_coordinate(x,y)
		BitmapUtils.validate_colour(new_colour)

		@pixels[y-1][x-1] = new_colour
	end

	def get_colour(x,y)
		validate_coordinate(x,y)

		@pixels[y-1][x-1]
	end

	def clear
		@pixels = Array.new(@height) {Array.new(@width, COLOUR_WHITE)}
	end

	private

	def validate_coordinate(x,y)
		BitmapUtils.validate_sizes(x, 'X', y, 'Y')
		raise ArgumentError.new("X should be less than width(#{@width})") if x > @width
		raise ArgumentError.new("Y should be less than height(#{@height})") if y > @height
	end

end
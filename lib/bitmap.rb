require 'bitmap_utils'

class Bitmap
	attr_reader :width, :height,:pixels

	COLOUR_WHITE = 'O'

	def initialize(new_width, new_height)
		BitmapUtils.validate_initials(new_width, new_height)
		@width = new_width
		@height = new_height
		self.clear
	end

	def to_s
		@pixels.inject('') {|result,row|  result + "#{row.join}\n" }.strip
	end

	def set_colour(x,y,new_colour)
		validate_coordinate(x,y)
		raise ArgumentError.new('Colour should be a single capital letter') unless  new_colour.match(/[[:upper:]]/) && (new_colour.size == 1)

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
		raise ArgumentError.new("X #{BitmapUtils::SIZE_PARAM_ERROR}") unless BitmapUtils.valid_size_param? x
		raise ArgumentError.new("X should be less than width(#{@width})") if x > @width
		raise ArgumentError.new("Y #{BitmapUtils::SIZE_PARAM_ERROR}") unless BitmapUtils.valid_size_param? y
		raise ArgumentError.new("Y should be less than height(#{@height})") if y > @height
	end

end
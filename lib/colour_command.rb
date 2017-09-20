require_relative 'bitmap_utils'
require_relative 'command'
require_relative 'bitmap'

class ColourCommand < Command
	attr_reader :x, :y, :colour

	def initialize(new_x, new_y, new_colour)
		BitmapUtils.validate_size(new_x, 'X')
		BitmapUtils.validate_size(new_y , 'Y')
		BitmapUtils.validate_colour(new_colour)
		@x = new_x
		@y = new_y
		@colour = new_colour
	end

	def execute(a_bitmap)
		return a_bitmap, '', Command::INVALID_BITMAP_ERROR unless a_bitmap.is_a? Bitmap

		bitmap = a_bitmap
		output_message = ''
		error_message = ''

		begin
			bitmap.set_colour(@x,@y,@colour)
		rescue => exc
			error_message = exc.message
		end

		return bitmap, output_message, error_message
	end

end
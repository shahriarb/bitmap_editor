require 'bitmap_command'

class BitmapColourCommand < BitmapCommand
	attr_reader :x, :y, :colour

	def initialize(new_x, new_y, new_colour)
		BitmapUtils.validate_sizes(new_x, 'X', new_y , 'Y')
		BitmapUtils.validate_colour(new_colour)
		@x = new_x
		@y = new_y
		@colour = new_colour
	end

	def execute(a_bitmap)
		return a_bitmap, '', 'This command needs a valid bitmap' unless a_bitmap.is_a? Bitmap

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
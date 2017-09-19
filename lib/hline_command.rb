require_relative 'command'

class HlineCommand < Command
	attr_reader :x1, :x2, :y, :colour

	def initialize(new_x1, new_x2, new_y, new_colour)
		BitmapUtils.validate_size(new_x1, 'X1')
		BitmapUtils.validate_size(new_x2 , 'X2')
		BitmapUtils.validate_size(new_y , 'Y')
		BitmapUtils.validate_colour(new_colour)
		@x1 = new_x1
		@x2 = new_x2
		@y = new_y
		@colour = new_colour

		if new_x2 > new_x1
			@lower_band = new_x1
			@upper_band = new_x2
		else
			@lower_band = new_x2
			@upper_band = new_x1
		end
	end

	def execute(a_bitmap)
		return a_bitmap, '', Command::INVALID_BITMAP_ERROR unless a_bitmap.is_a? Bitmap
		return a_bitmap, '', "X1 should be less than width(#{a_bitmap.width})" if @x1 > a_bitmap.width
		return a_bitmap, '', "X2 should be less than width(#{a_bitmap.width})" if @x2 > a_bitmap.width
		return a_bitmap, '', "Y should be less than height(#{a_bitmap.height})" if @y > a_bitmap.height

		bitmap = a_bitmap
		output_message = ''
		error_message = ''

		begin
			@lower_band.upto(@upper_band) {|x| bitmap.set_colour(x,@y,@colour)}
		rescue => exc
			error_message = exc.message
		end

		return bitmap, output_message, error_message
	end

end
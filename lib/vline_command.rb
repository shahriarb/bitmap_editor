require_relative 'command'

class VlineCommand < Command
	attr_reader :x, :y1, :y2, :colour

	def initialize(new_x, new_y1, new_y2, new_colour)
		BitmapUtils.validate_size(new_x, 'X')
		BitmapUtils.validate_size(new_y1 , 'Y1')
		BitmapUtils.validate_size(new_y2 , 'Y2')
		BitmapUtils.validate_colour(new_colour)
		@x = new_x
		@y1 = new_y1
		@y2 = new_y2
		@colour = new_colour

		if new_y2 > new_y1
			@lower_band = new_y1
			@upper_band = new_y2
		else
			@lower_band = new_y2
			@upper_band = new_y1
		end
	end

	def execute(a_bitmap)
		return a_bitmap, '', Command::INVALID_BITMAP_ERROR unless a_bitmap.is_a? Bitmap
		return a_bitmap, '', "X should be less than width(#{a_bitmap.width})" if @x > a_bitmap.width
		return a_bitmap, '', "Y1 should be less than height(#{a_bitmap.height})" if @y1 > a_bitmap.height
		return a_bitmap, '', "Y2 should be less than height(#{a_bitmap.height})" if @y2 > a_bitmap.height

		bitmap = a_bitmap
		output_message = ''
		error_message = ''

		begin
			@lower_band.upto(@upper_band) {|y| bitmap.set_colour(@x,y,@colour)}
		rescue => exc
			error_message = exc.message
		end

		return bitmap, output_message, error_message
	end

end
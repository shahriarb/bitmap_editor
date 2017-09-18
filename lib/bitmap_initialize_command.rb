require 'bitmap_command'

class BitmapInitializeCommand < BitmapCommand
	attr_reader :width, :height,:pixels

	def initialize(new_width, new_height)
		BitmapUtils.validate_initials(new_width, new_height)
		@width = new_width
		@height = new_height
	end

	def execute(a_bitmap)
		result_bitmap = nil
		output_message = ''
		error_message = ''
		begin
			result_bitmap = Bitmap.new(@width,@height)
		rescue => exc
			error_message = exc.message
		end
		return result_bitmap, output_message, error_message
	end

end
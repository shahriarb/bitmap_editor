require 'command'
require 'bitmap'

class ClearCommand < Command
	def execute(a_bitmap)
		return a_bitmap, '', Command::INVALID_BITMAP_ERROR unless a_bitmap.is_a? Bitmap

		bitmap = a_bitmap
		output_message = ''
		error_message = ''
		begin
			bitmap.clear
		rescue => exc
			error_message = exc.message
		end
		return bitmap, output_message, error_message
	end
end
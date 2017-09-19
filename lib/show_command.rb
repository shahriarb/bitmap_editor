require 'command'
require 'bitmap'

class ShowCommand < Command
	def execute(a_bitmap)
		return a_bitmap, '', Command::INVALID_BITMAP_ERROR unless a_bitmap.is_a? Bitmap

		bitmap = a_bitmap
		output_message = ''
		error_message = ''
		begin
			output_message = bitmap.to_s
		rescue => exc
			error_message = exc.message
		end
		return bitmap, output_message, error_message
	end
end
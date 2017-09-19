require_relative 'command'

class InitializeCommand < Command
	attr_reader :width, :height

	def initialize(new_width, new_height)
		BitmapUtils.validate_size(new_width, 'Width')
		BitmapUtils.validate_size(new_height, 'Height')
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
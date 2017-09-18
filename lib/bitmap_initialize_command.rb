require 'bitmap_command'

class BitmapInitializeCommand < BitmapCommand
	attr_reader :width, :height,:pixels

	def initialize(new_width, new_height)
		validate_initials(new_width, new_height)
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

	private

	def valid_size_param?(param)
		param.is_a?(Integer) && param > 0 && param <= Bitmap::MAX_LENGTH
	end

	def validate_initials(new_width, new_height)
		raise ArgumentError.new("Width #{Bitmap::SIZE_PARAM_ERROR}") unless valid_size_param?new_width
		raise ArgumentError.new("Height #{Bitmap::SIZE_PARAM_ERROR}") unless valid_size_param? new_height
	end

end
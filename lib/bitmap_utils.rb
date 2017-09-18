class BitmapUtils

	MAX_LENGTH = 250
	SIZE_PARAM_ERROR = "should be a valid integer between 1 and #{MAX_LENGTH}"

	def self.valid_size_param?(param)
		param.is_a?(Integer) && param > 0 && param <= MAX_LENGTH
	end

	def self.validate_initials(new_width, new_height)
		raise ArgumentError.new("Width #{SIZE_PARAM_ERROR}") unless self.valid_size_param?new_width
		raise ArgumentError.new("Height #{SIZE_PARAM_ERROR}") unless self.valid_size_param? new_height
	end

end
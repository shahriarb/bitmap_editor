class BitmapUtils

	MAX_LENGTH = 250
	SIZE_PARAM_ERROR = "should be a valid integer between 1 and #{MAX_LENGTH}"

	def self.valid_size_param?(param)
		param.is_a?(Integer) && param > 0 && param <= MAX_LENGTH
	end

	def self.validate_size(size,size_label)
		raise ArgumentError.new("#{size_label} #{SIZE_PARAM_ERROR}") unless self.valid_size_param?size
	end

	def self.validate_colour(new_colour)
		raise ArgumentError.new('Colour should be a single capital letter') unless  new_colour.match(/[[:upper:]]/) && (new_colour.size == 1)
	end
end
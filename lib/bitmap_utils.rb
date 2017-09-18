class BitmapUtils

	MAX_LENGTH = 250
	SIZE_PARAM_ERROR = "should be a valid integer between 1 and #{MAX_LENGTH}"

	def self.valid_size_param?(param)
		param.is_a?(Integer) && param > 0 && param <= MAX_LENGTH
	end

	def self.validate_sizes(param1,param1_label, param2, param2_label )
		raise ArgumentError.new("#{param1_label} #{SIZE_PARAM_ERROR}") unless self.valid_size_param?param1
		raise ArgumentError.new("#{param2_label} #{SIZE_PARAM_ERROR}") unless self.valid_size_param? param2
	end

	def self.validate_colour(new_colour)
		raise ArgumentError.new('Colour should be a single capital letter') unless  new_colour.match(/[[:upper:]]/) && (new_colour.size == 1)
	end
end
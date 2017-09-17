class Bitmap
	attr_reader :width, :height,:pixels

	COLOUR_WHITE = 'O'
	MAX_LENGTH = 250
	SIZE_PARAM_ERROR = "should be a valid integer between 1 and #{MAX_LENGTH}"

	def initialize(new_width, new_height)
		validate_initials(new_width, new_height)
		@width = new_width
		@height = new_height
		@pixels = Array.new(@height) {Array.new(@width, COLOUR_WHITE)}
	end

	def to_s
		@pixels.inject('') {|result,row|  result + "#{row.join}\n" }.strip
	end

	def set_colour(x,y,new_colour)
		validate_coordinate(x,y)
		raise ArgumentError.new('Colour should be a single capital letter') unless  new_colour.match(/[[:upper:]]/) && (new_colour.size == 1)

		@pixels[y-1][x-1] = new_colour
	end

	def get_colour(x,y)
		validate_coordinate(x,y)

		@pixels[y-1][x-1]
	end

	private

	def valid_size_param?(param)
		param.is_a?(Integer) && param > 0 && param <= MAX_LENGTH
	end

	def validate_initials(new_width, new_height)
		raise ArgumentError.new("Width #{SIZE_PARAM_ERROR}") unless valid_size_param?new_width
		raise ArgumentError.new("Height #{SIZE_PARAM_ERROR}") unless valid_size_param? new_height
	end

	def validate_coordinate(x,y)
		raise ArgumentError.new("X #{SIZE_PARAM_ERROR}") unless valid_size_param?x
		raise ArgumentError.new("X should be less than width(#{@width})") if x > @width
		raise ArgumentError.new("Y #{SIZE_PARAM_ERROR}") unless valid_size_param? y
		raise ArgumentError.new("Y should be less than height(#{@height})") if y > @height
	end

end
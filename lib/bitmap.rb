class Bitmap
	attr_reader :width, :height,:pixels

	COLOUR_WHITE = 'O'

	def initialize(new_width, new_height)
		raise 'Width should be a valid integer' unless new_width.is_a? Integer
		raise 'Height should be a valid integer' unless new_height.is_a? Integer
		raise 'Width should be a positive integer' if  new_width < 0
		raise 'Height should be a positive integer' if  new_height < 0
		raise 'Width should be less than 250' if  new_width > 250
		raise 'Height should be less than 250' if  new_height > 250

		@width = new_width
		@height = new_height
		@pixels = Array.new(@height) {Array.new(@width, COLOUR_WHITE)}
	end

	def to_s
		@pixels.inject('') {|result,row|  result + "#{row.join}\n" }.strip
	end

	def set_colour(x,y,new_colour)
		raise 'X should be a valid integer' unless x.is_a? Integer
		raise 'X coordinate should be between 1 and 250' unless x > 0 && x <= 250
		raise "X coordinate should be less than width(#{@width})" if x > @width
		raise 'Y should be a valid integer' unless y.is_a? Integer
		raise 'Y coordinate should be between 1 and 250' unless y > 0 && y <= 250
		raise "Y coordinate should be less than height(#{@height})" if y > @height
		raise 'Colour should be a single capital letter' unless  new_colour.match(/[[:upper:]]/) && (new_colour.size == 1)

		@pixels[y-1][x-1] = new_colour
	end
end
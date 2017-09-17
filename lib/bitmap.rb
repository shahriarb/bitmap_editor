class Bitmap
	attr_reader :width, :height,:pixels

	COLOR_WHITE = 'O'

	def initialize(new_width, new_height)
		raise 'Width should be a valid integer' unless new_width.is_a? Integer
		raise 'Height should be a valid integer' unless new_height.is_a? Integer
		raise 'Width should be a positive integer' if  new_width < 0
		raise 'Height should be a positive integer' if  new_height < 0
		raise 'Width should be less than 250' if  new_width > 250
		raise 'Height should be less than 250' if  new_height > 250

		@width = new_width
		@height = new_height
		@pixels = Array.new(@height) {Array.new(@width,COLOR_WHITE)}
	end

	def to_s
		@pixels.inject('') {|result,row|  result + "#{row.join}\n" }.strip
	end

end
class Command

	INVALID_BITMAP_ERROR = 'There is no image'

	def execute
		raise NotImplementedError.new
	end
end
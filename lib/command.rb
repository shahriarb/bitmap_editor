class Command

	INVALID_BITMAP_ERROR = 'This command needs a valid bitmap'

	def execute
		raise NotImplementedError.new
	end
end
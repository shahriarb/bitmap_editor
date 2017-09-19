class CommandFactory
	VALID_COMMANDS = [:initialize, :clear, :colour, :vline, :hline, :show]

	COMMANDS_ABBR = {
		:initialize => 'I',
		:clear 	 	=> 'C',
		:colour	 	=> 'L',
		:vline	 	=> 'V',
		:hline	    => 'H',
		:show		=> 'S'
	}

	INVALID_ABBR = 'abbreviation is not valid'

	def self.abbr_to_command(abbreviation)
		raise ArgumentError.new(INVALID_ABBR) unless abbreviation

		result = COMMANDS_ABBR.key(abbreviation)
		raise ArgumentError.new(INVALID_ABBR) unless result

		result
	end
end
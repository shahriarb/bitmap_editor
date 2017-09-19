require_relative 'initialize_command'
require_relative 'clear_command'
require_relative 'colour_command'
require_relative 'vline_command'
require_relative 'hline_command'
require_relative 'show_command'

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

	INVALID_ABBR = 'unrecognised command'
	INVALID_COMMAND = 'command is not valid'

	def self.abbr_to_command(abbreviation)
		raise ArgumentError.new(INVALID_ABBR) unless abbreviation

		result = COMMANDS_ABBR.key(abbreviation)
		raise ArgumentError.new(INVALID_ABBR) unless result

		result
	end

	def self.create(command, *params)
		case command
			when :initialize
				new_width = params[0].to_i rescue 0
				new_height = params[1].to_i rescue 0
				return InitializeCommand.new(new_width,new_height)
			when :clear
				return ClearCommand.new
			when :colour
				new_x = params[0].to_i rescue 0
				new_y = params[1].to_i rescue 0
				return ColourCommand.new(new_x,new_y,params[2])
			when :vline
				new_x = params[0].to_i rescue 0
				new_y1 = params[1].to_i rescue 0
				new_y2 = params[2].to_i rescue 0
				return VlineCommand.new(new_x,new_y1,new_y2,params[3])
			when :hline
				new_x1 = params[0].to_i rescue 0
				new_x2 = params[1].to_i rescue 0
				new_y  = params[2].to_i rescue 0
				return HlineCommand.new(new_x1,new_x2,new_y,params[3])
			when :show
				return ShowCommand.new
			else
				raise ArgumentError.new(INVALID_COMMAND)
		end
	end
end
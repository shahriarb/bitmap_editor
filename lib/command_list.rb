require_relative 'command'

class CommandList
	attr_reader :commands, :bitmap

	def initialize
		@commands = []
		@bitmap = nil
	end

	def add_command(new_command)
		raise ArgumentError.new('Command is not valid') unless new_command.is_a? Command
		@commands << new_command
	end

	def execute(a_bitmap)
		@bitmap = a_bitmap
		output_message = ''
		error_message = ''
		@commands.each do |command|
			@bitmap, output, error_message = command.execute(@bitmap)
			output_message += "\n" unless output_message == ''
			output_message += output
			break unless error_message == ''
		end

		return @bitmap, output_message, error_message
	end
end
require_relative 'input_handler'
require_relative 'command_list'
require_relative 'command_factory'

class BitmapEditor
	def run(file)
		commands, errors = InputHandler.load_from_file(file)
		return puts errors.join("\n") unless errors.empty?


		command_list = CommandList.new
		errors = []

		commands.each_with_index do |command, index|
			begin
				command_list.add_command(CommandFactory.create(command[:command],*command[:params]))
			rescue => exc
				errors << "Error line(#{index + 1}):\t#{exc.message}"
			end
		end

		return puts errors.join("\n") unless errors.empty?

		_, output_message, error_message = command_list.execute(nil)
		output_message = error_message unless error_message ==  ''
		puts output_message unless output_message ==  ''
	end
end

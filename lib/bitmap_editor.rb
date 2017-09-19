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
				errors << "Error line(#{index + 1}):\n#{exc.message}"
			end
		end

		return puts errors.join("\n") unless errors.empty?
	end
end

require_relative 'command_factory'

class InputHandler
	def self.parse_line(new_line)
		raise ArgumentError.new('Input line can not be empty') if new_line.nil? || new_line.empty?
		splited = new_line.strip.split
		command = CommandFactory.abbr_to_command(splited[0])
		params = splited[1..-1]
		params ||= []
		return {:command => command, :params => params}
	end

	def self.load_from_file(new_file)
		return nil, ['please provide correct file'] if new_file.nil? || !File.exists?(new_file)

		commands = []
		errors = []
		index = 0
		File.open(new_file).each do |line|
			index += 1
			begin
				commands << self.parse_line(line.strip)
			rescue => exc
				errors << "Error line(#{index}):\t#{exc.message}"
			end
		end

		return commands, errors
	end
end
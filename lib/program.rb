require './lib/program_result'
require './lib/gem_info'
require './lib/api_client'
require './lib/commands/command_factory'
require './lib/commands/command'

class Program
    def execute(args)

        if args.empty?
            return ProgramResult.new(1, 'No command given')
        end

        command_name = args[0]

        command = CommandFactory.find(command_name)

        if command.nil?
            return ProgramResult.new(2, 'Command unknown')
        end

        command.execute(args[1])
    end
end
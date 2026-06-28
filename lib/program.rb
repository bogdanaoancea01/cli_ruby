# frozen_string_literal: true

require './lib/program_result'
require './lib/gem_info'
require './lib/api_client'
require './lib/commands/command_factory'
require './lib/commands/command'

class Program
  def execute(args)
    return ProgramResult.new(1, 'No command given') if args.empty?

    command_name = args[0]

    command = CommandFactory.find(command_name)

    return ProgramResult.new(2, 'Command unknown') if command.nil?

    command.execute(args[1..])
  end
end

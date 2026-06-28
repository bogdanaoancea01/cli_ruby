# frozen_string_literal: true

require './lib/program_result'
require './lib/gem_info'
require './lib/api_client'
require './lib/commands/command'

class ShowCommand < Command
  def initialize(client = APIClient)
    @client = client
  end

  def execute(args)
    gem_name = args.first if args

    return ProgramResult.new(3, 'No gem name given') if gem_name.nil?

    api_json_response = @client.show(gem_name)

    return ProgramResult.new(4, 'Gem not found') if api_json_response == 'Gem not found'

    gem = GemInfo.new(api_json_response['name'], api_json_response['info'])

    ProgramResult.new(0, "Gem name: #{gem.name}\nGem info: #{gem.info}")
  end
end

# frozen_string_literal: true

require './lib/program_result'
require './lib/gem_info'
require './lib/api_client'
require './lib/commands/command'
require './lib/options/option_factory'

class SearchCommand < Command
  def initialize(client = APIClient)
    @client = client
  end

  def execute(args)
    return ProgramResult.new(3, 'No keyword given') if args.nil?

    keyword = args[0]
    option = args[1]
    option_value = args[2]

    api_response = @client.search(keyword)

    return ProgramResult.new(4, 'No gems found') if api_response.empty?

    gems = api_response

    if option
      option_cmd = OptionFactory.find(option)
      gems = option_cmd.execute(gems, option_value) if option
    end

    gems = gems.map { |gem| GemInfo.new(gem['name'], gem['info']) }

    exit_description = gems.map do |gem|
      gem.name.to_s
    end.join("\n")

    ProgramResult.new(0, exit_description)
  end
end

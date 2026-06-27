# frozen_string_literal: true

require './lib/program_result'
require './lib/gem_info'
require './lib/api_client'
require './lib/commands/command'
require './lib/options/option_factory'
require './lib/options/parse_options'

class SearchCommand < Command
  def initialize(client = APIClient)
    @client = client
  end

  def execute(args)
    return ProgramResult.new(3, 'No keyword given') if args.nil?

    keyword = args[0]

    options = ParseOptions.execute(args[1..])

    api_response = @client.search(keyword)

    return ProgramResult.new(4, 'No gems found') if api_response.empty?

    gems = api_response

    option_cmd = OptionFactory.find('licence') if options.licence
    option_cmd = OptionFactory.find('sort') if options.sort
    option_cmd = OptionFactory.find('sort-and-filter') if options.licence && options.sort

    gems = option_cmd.execute(gems, options.licence.to_s) if option_cmd

    gems = gems.map { |gem| GemInfo.new(gem['name'], gem['info']) }

    exit_description = gems.map do |gem|
      gem.name.to_s
    end.join("\n")

    ProgramResult.new(0, exit_description)
  end
end

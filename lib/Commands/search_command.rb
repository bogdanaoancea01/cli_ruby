# frozen_string_literal: true

require './lib/program_result'
require './lib/gem_info'
require './lib/api_client'
require './lib/commands/command'
require './lib/options/parse_options'
require 'pry'

class SearchCommand < Command
  def initialize(client = APIClient)
    @client = client
  end

  def execute(args)
    return ProgramResult.new(3, 'No keyword given') if args.nil?

    keyword = args[0]

    api_response = @client.search(keyword)

    return ProgramResult.new(4, 'No gems found') if api_response.empty?

    gems = api_response

    options = ParseOptions.execute(args[1..])

    options.each { |opt| opt.execute(gems) }

    gems = gems.map { |gem| GemInfo.new(gem['name'], gem['info']) }

    exit_description = gems.map do |gem|
      gem.name.to_s
    end.join("\n")

    ProgramResult.new(0, exit_description)
  end
end

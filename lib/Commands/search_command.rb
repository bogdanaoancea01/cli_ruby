# frozen_string_literal: true

require './lib/program_result'
require './lib/gem_info'
require './lib/api_client'
require './lib/commands/command'

class SearchCommand < Command
  def initialize(client = APIClient)
    @client = client
  end

  def execute(keyword)
    return ProgramResult.new(3, 'No keyword given') if keyword.nil?

    api_response = @client.search(keyword)

    return ProgramResult.new(4, 'No gems found') if api_response.empty?

    gems = api_response.map { |gem| GemInfo.new(gem['name'], gem['info']) }

    exit_description = gems.map do |gem|
      gem.name.to_s
    end.join("\n")

    ProgramResult.new(0, exit_description)
  end
end

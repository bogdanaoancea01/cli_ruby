# frozen_string_literal: true

require './lib/commands/show_command'
require './lib/commands/search_command'

class CommandFactory
  COMMANDS = {
    'show' => ShowCommand.new,
    'search' => SearchCommand.new
  }.freeze

  def self.find(name)
    COMMANDS[name]
  end
end

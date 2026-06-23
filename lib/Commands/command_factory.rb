# frozen_string_literal: true

require './lib/commands/show_command'

class CommandFactory
  COMMANDS = {
    'show' => ShowCommand.new
  }.freeze

  def self.find(name)
    COMMANDS[name]
  end
end

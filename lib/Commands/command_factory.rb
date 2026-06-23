require './lib/commands/show_command'

class CommandFactory
  COMMANDS = {
    'show' => ShowCommand.new
  }

  def self.find(name)
    COMMANDS[name]
  end
end
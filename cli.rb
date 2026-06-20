require "bundler/setup"
require './lib/program'

result = Program.new.execute(ARGV)
puts result.exit_code
puts result.exit_description

exit(exit_code)

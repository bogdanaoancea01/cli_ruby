require './lib/program_result'
require './lib/gem_info'
require './lib/api_client'

class Program
    def execute(args)

        command = args[0]
        gem_name = args[1]

        if command.nil?
            ProgramResult.new(1, "No command given")
        elsif !command.eql?("show")
            ProgramResult.new(2, "Command unknown")
            
        elsif gem_name.nil?
            ProgramResult.new(3, "No gem name given")
        else
            gem_json = APIClient.show(gem_name)
            gem_object = GemInfo.new(gem_json['name'], gem_json['info'])

            ProgramResult.new(0, "Gem name: #{gem_object.name} Gem info: #{gem_object.info}")
        end
    end
end
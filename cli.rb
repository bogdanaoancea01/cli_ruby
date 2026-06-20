require "bundler/setup"
require "faraday"
require_relative "api_client"

command = ARGV[0]
gem_name = ARGV[1]

if command.nil?
    puts "Error - missing command"
    exit 1
elsif !command.eql?("show")
    puts "Error - unknown command"
    exit 1
else
    if gem_name.nil?
        puts "Error -  missing gem name"
        exit 1
    end
    gem_info = APIClient.show(gem_name)
    puts "Name: #{gem_info['name']}"
    puts "Info: #{gem_info['info']}"
end

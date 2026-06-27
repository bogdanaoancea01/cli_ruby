require 'optparse'
require './lib/options/option_info'

class ParseOptions
    def self.execute(args)
        licence_name = nil
        is_sort = false

        parser = OptionParser.new
        parser.on('--licence LICENCE_NAME') do |value|
            licence_name = value
        end
        parser.on('--most-downloads-first') do |value|
            is_sort = true
        end

        parser.parse!(args)
        OptionInfo.new(licence_name, is_sort)

    end
end
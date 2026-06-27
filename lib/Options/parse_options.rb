require 'optparse'
require './lib/options/option_info'

class ParseOptions
    def self.execute(args)
        licence_name = nil
        sort_by_downloads = false

        parser = OptionParser.new
        parser.on('--licence LICENCE_NAME') do |value|
            licence_name = value
        end
        parser.on('--most-downloads-first') do |value|
            sort_by_downloads = true
        end

        parser.parse!(args)
        OptionInfo.new(licence_name, sort_by_downloads)

    end
end
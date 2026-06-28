require 'optparse'
require './lib/options/licence_option'
require './lib/options/sort_option'

class ParseOptions
    def self.execute(args)
        options = []

        parser = OptionParser.new
        parser.on('--licence LICENCE_NAME') do |value|
            options.append(LicenceOption.new(value))
        end
        parser.on('--most-downloads-first') do |value|
            options.append(SortOption.new)
        end

        parser.parse!(args)

        options

    end
end
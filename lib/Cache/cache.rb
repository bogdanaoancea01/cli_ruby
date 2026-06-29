# frozen_string_literal: true

require 'json'
require 'fileutils'

class Cache
    def initialize
        @cache_folder = 'cache'
        FileUtils.mkdir_p(@cache_folder)
    end

    def get(gem_name)
        file_name = "#{@cache_folder}/#{gem_name}.json"

        if File.exist?(file_name)
            file_age = Time.now - File.mtime(file_name)

            if file_age < 2 * 24 * 60 * 60
                file = File.read(file_name)
                return JSON.parse(file)
            else
                File.delete(file_name)
            end
        end
        nil
    end

    def save(gem_name, gems)
        file_name = "#{@cache_folder}/#{gem_name}.json"

        File.write(file_name, JSON.pretty_generate(gems))
    end
end
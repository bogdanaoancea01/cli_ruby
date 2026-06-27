# frozen_string_literal: true

require './lib/options/option'
require './lib/program_result'

class LicenceOption < Option
  def execute(gems, value)
    gems.select do |gem|
      gem['licenses']&.include?(value)
    end
  end
end

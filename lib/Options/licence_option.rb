# frozen_string_literal: true

require './lib/options/option'

class LicenceOption < Option
  def execute(gems, value)
    gems.select do |gem|
      gem['licenses']&.include?(value)
    end
  end
end

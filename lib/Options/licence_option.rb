# frozen_string_literal: true

require './lib/options/option'

class LicenceOption < Option
  attr_reader :licence_name

  def initialize(licence_name)
    @licence_name = licence_name
  end

  def execute(gems)
    gems.select! do |gem|
      gem['licenses']&.include?(licence_name)
    end
  end
end

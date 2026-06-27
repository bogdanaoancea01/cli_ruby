# frozen_string_literal: true

require './lib/options/licence_option'

class OptionFactory
  OPTIONS = {
    '--licence' => LicenceOption.new
  }.freeze

  def self.find(name)
    OPTIONS[name]
  end
end

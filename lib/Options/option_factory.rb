# frozen_string_literal: true

require './lib/options/licence_option'
require './lib/options/sort_option'

class OptionFactory
  OPTIONS = {
    '--most-downloads-first' => SortOption.new,
    '--licence' => LicenceOption.new
  }.freeze

  def self.find(name)
    OPTIONS[name]
  end
end

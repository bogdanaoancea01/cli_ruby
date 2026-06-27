# frozen_string_literal: true

require './lib/options/licence_option'
require './lib/options/sort_option'
require './lib/options/sort_and_filter'

class OptionFactory
  OPTIONS = {
    'sort' => SortOption.new,
    'licence' => LicenceOption.new,
    'sort-and-filter' => SortAndFilter.new
  }.freeze

  def self.find(name)
    OPTIONS[name]
  end
end

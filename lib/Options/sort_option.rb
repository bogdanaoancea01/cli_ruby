# frozen_string_literal: true

require './lib/options/option'

class SortOption < Option
  def execute(gems, option_value = nil)
    gems.sort_by! { |gem| gem['downloads'].to_i }.reverse
  end
end

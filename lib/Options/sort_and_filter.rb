# frozen_string_literal: true

require './lib/options/option'

class SortAndFilter < Option
  def execute(gems, value = nil)
    gems
      .select { |gem| gem['licenses']&.include?(value) }
      .sort_by { |gem| gem['downloads'].to_i }
      .reverse
  end
end
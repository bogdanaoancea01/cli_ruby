# frozen_string_literal: true

class OptionInfo
  attr_reader :licence, :sort

  def initialize(licence, sort)
    @licence = licence
    @sort = sort
  end
end
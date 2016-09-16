require 'colorize'

class Tile
  attr_reader :given, :value

  def initialize(value)
    if value == "0"
      @given = false
      @value = " "
    else
      @given = true
      @value = value
    end
  end

  def display
    if @given
      value.red
    else
      value.green
    end
  end

  def change_value(value)
    unless @given
      @value = value
    end
  end
end

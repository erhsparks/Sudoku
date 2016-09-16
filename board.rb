require_relative 'tile'

class Board
  attr_reader :grid

  HEADER = "  "+" 1 2 3   4 5 6   7 8 9 ".underline

  def self.from_file(file = "sudoku1.txt")
    grid = File.readlines(file)
    grid.map! do |line|
      line = line.strip.split("")
      line.map! do |value|
        tile = Tile.new(value)
      end
    end
  end

  def initialize(grid = nil)
    if grid
      @grid = grid
    else
      @grid = Board::from_file
    end
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, value)
    @grid[row][col].change_value(value.to_s)
  end

  def render
    puts HEADER
    grid.each_with_index do |row, i|
      display_row(row, i)
      display_spacer if i == 2 || i == 5 || i == 8
    end
  end

  def display_copy(row)
    temp_row = row.map { |tile| tile.display }
    temp_row = temp_row[0..2] + ["|"] +
      temp_row[3..5] + ["|"] + temp_row[6..8]
    temp_row.join(" ")
  end

  def display_row(row, index)
    puts "#{index+1}| #{display_copy(row)} |"
  end

  def display_spacer
    puts " |-------|-------|-------|"
  end

  def solved?
    rows_solved? && cols_solved? && boxes_solved?
  end

  def rows_solved?
    grid.all? { |row| nonet_valid?(row) }
  end

  def cols_solved?
    flipped_grid = grid.transpose
    flipped_grid.all? { |row| nonet_valid?(row) }
  end

  def nonet_valid?(tileset)
    test_set = tileset.map { |tile| tile.value.to_i }
    test_set.sort == (1..9).to_a
  end

  def boxes_solved?
    
  end
end

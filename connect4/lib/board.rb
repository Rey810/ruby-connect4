
class Board
    attr_accessor :grid

    def initialize
        @grid = Array.new(7) { Array.new(6) { nil } }
    end

    def place_piece(col, piece)
        col = col_check?(col)
        row = 0
        until @grid[col - 1][row].nil?
            row += 1
        end
        @grid[col - 1][row] = piece
    end

    def col_check?(col)
        if col <= 7 && col >= 0 
            col
        else
            enter_new_column
        end
    end

    def enter_new_column
        puts "Please enter a valid column:"
        col = gets.chomp
        col = col.to_i
        col_check?(col)
    end

    def winner?(piece)
        colour = piece.colour
        (0..(@grid.length - 1)).each do |col|
          (0..(@grid[0].length - 1)).each do |row|
            if @grid[col][row] && @grid[col][row].colour == colour
              if row < (@grid[0].length - 3)
                if vertical_check(colour, col, row) 
                  return true
                end
              end
              if col < (@grid.length - 3)
                if horizontal_check(colour, col, row)
                  return true
                end
              end
              if (col < (@grid.length - 3)) && (row < (@grid.length - 3))
                if diagonal_up_check(colour, col, row)
                  return true
                end
              end
              if (col < (@grid.length - 3)) && (row >= (@grid.length - 3))
                if diagonal_down_check(colour, col, row)
                  return true
                end
              end
            end
          end
        end
        return false
    end

    def diagonal_down_check(colour, col, row)
    in_a_row = 1
    3.times do |index|
      if @grid[col + index + 1][row - index - 1]
        if @grid[col + index + 1][row - index - 1].colour == colour
          in_a_row += 1
        end
      end
    end
    if in_a_row == 4
      return true
    else false
    end
  end

  def diagonal_up_check(colour, col, row)
    in_a_row = 1
    3.times do |index|
      if @grid[col + index + 1][row + index + 1]
        if @grid[col + index + 1][row + index + 1].colour == colour
          in_a_row += 1
        end
      end
    end
    if in_a_row == 4
      return true
    else false
    end
 
  end

  def horizontal_check(colour, col, row)
    in_a_row = 1
    3.times do |index|
      if @grid[col + index + 1][row]
        if @grid[col + index + 1][row].colour == colour
          in_a_row += 1
        end
      end
    end
    if in_a_row == 4
      return true
    else false
    end
  end

  def vertical_check(colour, col, row)
    in_a_row = 1
    3.times do |index|
      if @grid[col][row + index + 1]
        if @grid[col][row + index + 1].colour == colour
          in_a_row += 1
        end
      end
    end
    if in_a_row == 4
      return true
    else false
    end
  end

    def print_board
        (@grid[0].length - 1).downto(0) do |row|
            @grid.length.times do |col|
              print "|"
              if @grid[col][row] && @grid[col][row].colour == "red"
                print "\e[31m#{"\u25cf"}\e[0m" # red circle
              elsif @grid[col][row] && @grid[col][row].colour == "blue"
                print "\e[34m#{"\u25cf"}\e[0m" # blue circle
              else print " "
              end
            end
        puts "|"
        end
    end

    def board_full?
        (@grid[0].length - 1).downto(0) do |row|
            @grid.length.times do |col|
                if @grid[col][row] == nil
                    return false
                end
            end
        end
        return true
    end
end

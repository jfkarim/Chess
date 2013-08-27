require_relative 'tile'
require_relative 'piece'
require_relative 'pawn'

class Board

  def initialize()
    @board = []
    8.times { @board << Array.new(8, Tile.new) }
  end

  def [](row, col)
    @board[row][col]
  end

  def populate_board
    #take starting locations of each piece based on class
    #account for pawns and other amounts of pieces
    @board[1][1] = Pawn.new([1,1], 'white')
  end

end

b = Board.new
b.populate_board
p b[1,1]
require_relative 'tile'
require_relative 'piece'
require_relative 'pawn'

class Board

  PIECE_INITIALS = {'p' => [[1,0], [1,1], [1,2], [1,3], [1,4], [1,5], [1,6], [1,7],
                            [6,0], [6,1], [6,2], [6,3], [6,4], [6,5], [6,6], [6,7]]

                    'R' => [[0,0], [7,7], [7,0], [0,7]]

                    'N' => [[0,1], [7,6], [7,1], [0,6]]

                    'B' => [[0,2], [7,5], [7,2], [0,5]]

                    'Q' => [[7,4], [0,4]]

                    'K' => [[7,3], [0,3]]
                  }

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
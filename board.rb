class Board

  def initialize()
    @board = []
    8.times { @board << Array.new(8, Tile.new) }
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def populate_board
    #take starting locations of each piece based on class
    #account for pawns and other amounts of pieces
  end


  end
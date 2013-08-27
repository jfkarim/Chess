require 'colorize'
require_relative 'tile'
require_relative 'piece'
require_relative 'pawn'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'



class Board

  PIECE_INITIALS = {'p' => [[1,0], [1,1], [1,2], [1,3], [1,4], [1,5], [1,6], [1,7],
                            [6,0], [6,1], [6,2], [6,3], [6,4], [6,5], [6,6], [6,7]],

                    'R' => [[0,0], [7,7], [7,0], [0,7]],

                    'N' => [[0,1], [7,6], [7,1], [0,6]],

                    'B' => [[0,2], [7,5], [7,2], [0,5]],

                    'Q' => [[7,4], [0,4]],

                    'K' => [[7,3], [0,3]]
                  }

  attr_accessor :threatened_by_white, :threatened_by_black

  def initialize()
    @board = []
    8.times { @board << Array.new(8) { Tile.new } }
  end


  def [](row, col)
    @board[row][col]
  end

  def temp_board
    @board.each do |row|
      row.each do |tile|
        tile.dup
      end
    end
  end

  def populate_board
    # take starting locations of each piece based on class
    # account for pawns and other amounts of pieces
    PIECE_INITIALS.each do |key, value|
      case key
        when 'p'
          value.each { |row, col| @board[row][col].piece = Pawn.new([row, col], initial_color?(row)) }
        when 'R'
          value.each { |row, col| @board[row][col].piece = Rook.new([row, col], initial_color?(row)) }
        when 'N'
          value.each { |row, col| @board[row][col].piece = Knight.new([row, col], initial_color?(row)) }
        when 'B'
          value.each { |row, col| @board[row][col].piece = Bishop.new([row, col], initial_color?(row)) }
        when 'Q'
          value.each { |row, col| @board[row][col].piece = Queen.new([row, col], initial_color?(row)) }
        when 'K'
          value.each { |row, col| @board[row][col].piece = King.new([row, col], initial_color?(row)) }
       end
     end
   end

  def display_board
    display = @board.map  { |row| '|' + row.map {|tile| tile.occupied? ? color_icon(tile.piece) : '_'}.join('|') + '|' }
    ["_________________"] + display + ["_________________"]
  end

  private
  def initial_color? (row)
    return 'white' if row < 3
    'black'
  end

  def color_icon(piece)
    piece.color == 'white' ? piece.type.red : piece.type.blue
  end

end

b = Board.new
t = Tile.new
t.piece = Pawn.new([1,1], "white")
puts t.piece
b.populate_board
puts b.display_board

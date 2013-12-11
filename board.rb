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

  SYMBOL_HASH = {
                  ['black','p'] => "\u{265F}",
                  ['black','R'] => "\u{265C}",
                  ['black','N'] => "\u{265E}",
                  ['black','B'] => "\u{265D}",
                  ['black','Q'] => "\u{265B}",
                  ['black','K'] => "\u{265A}",
                  ['white','p'] => "\u{2659}",
                  ['white','R'] => "\u{2656}",
                  ['white','B'] => "\u{2657}",
                  ['white','N'] => "\u{2658}",
                  ['white','Q'] => "\u{2655}",
                  ['white','K'] => "\u{2654}"
                 }

  attr_accessor :black_piece_count, :white_piece_count,:threatened_by_white, :threatened_by_black, :board

  def initialize()
    @board = []
    8.times { @board << Array.new(8) { Tile.new } }
    @black_piece_count = []
    @white_piece_count = []
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
     piece_counter
   end

  def display_board
    letters = ('A'..'H').to_a
    display = @board.map  { |row| letters.shift + '|' + row.map {|tile| tile.occupied? ? SYMBOL_HASH[[tile.piece.color, tile.piece.type]] : '_' } .join('|') + '|' }
    display = ["  1 2 3 4 5 6 7 8"] + display + ["__________________"]
    puts display
    puts "Black piece count:"
    puts @black_piece_count.length
    puts "White piece count:"
    puts @white_piece_count.length
  end

  def piece_counter
    @black_piece_count = []
    @white_piece_count = []
    @board.each do |row|
      row.each do |tile|
        if tile.occupied?
          tile.piece.color == "white" ? @white_piece_count << tile.piece : @black_piece_count << tile.piece
        end
      end
    end
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

require_relative 'humanplayer'

require_relative 'board'


class Chess

  DIAGONALS = (0...8).
              to_a.map{ |row_coord| [row_coord, row_coord] } + (0...8).
              to_a.map{ |row_coord| [7 - row_coord, row_coord] }

  HORIZONTALS = (0...8).to_a.map{ |col_coord| [0, col_coord] }

  VERTICALS = (0...8).to_a.map{ |row_coord| [row_coord, 0] }

  attr_accessor :game_board, :current_player, :player1, :player2

  def initialize ()
    self.game_board = Board.new
    self.current_player = nil
    @player1 = nil
    @player2 = nil
  end

  # METHODS RELATED TO SETUP

  def set_players
    puts "How many human players? (0,1,2)"
    answer = gets.chomp
    answer = answer =~ /[0-2]/ ? answer : set_players
    if answer == 2
      @player1 = HumanPlayer.new
      @player2 = HumanPlayer.new
      setup_players
    elsif answer == 1
      @player1 = HumanPlayer.new
      @player2 = HumanPlayer.new
      setup_players
    else
      @player1 = HumanPlayer.new('white')
      @player2 = HumanPlayer.new('black')
    end
    setup_players
  end

  def setup_players
    @player1.color = @player1.color_choice
    @player2.color = @player1.color == "black" ? "white" : "black"
    self.current_player = @player1
  end

  # METHODS RELATED TO CONTROL FLOW

  def play

    @game_board.populate_board

    until win?
      turn
    end

    play_again?
  end

  def move
    request_coordinates = current_player.request_inputs
    origin = request_coordinates[0]
    destination = request_coordinates[1]
    chosen_tile = @game_board[origin[0]][origin[1]]
    make_move(origin, destination) if valid?(origin, destination, tile)
    win?
  end

  def turn
    move
    change_current_player
  end

  # METHODS RELATED TO MOVEMENT CALCULATION

  def make_move(origin, destination)
    temp = @game_board[origin[0]][origin[1]].piece.dup
    @game_board[destination[0]][destination[1]].piece = temp
    @game_board[origin[0]][origin[1]].piece = nil
  end

  def valid?(origin, destination, tile)
    if tile.piece != nil

      piece = tile.piece
      raw_possible_moves = piece.raw_possible_moves(origin)

      if valid_moves(raw_possible_moves, piece.type, piece.color).include? (destination)
        return true
      end
    end
    false
  end

  def valid_moves(raw_possible_moves, type, color)
    case type
    when 'Q'
      (collision_check(VERTICALS, type, color) +
      collision_check(DIAGONALS, type, color) +
      collision_check(HORIZONTALS, type, color)) &
      raw_possible_moves
      #add them together
    when 'K'
      (collision_check(VERTICALS, type, color) +
      collision_check(DIAGONALS, type, color) +
      collision_check(HORIZONTALS, type, color)) &
      raw_possible_moves
    when 'R'
      (collision_check(VERTICALS, type, color) +
      collision_check(HORIZONTALS, type, color)) &
      raw_possible_moves
    when 'B'
      collision_check(DIAGONALS, type, color) &
      raw_possible_moves
    when 'p'
      # May work, need to add diagonals in pawn's constants
      (collision_check(VERTICALS, type, color) +
      collision_check(DIAGONALS, type, color)) &
      raw_possible_moves
  end

  def collision_check(constant, type, color)
    valids = []

    constant.each do |pos|
      tile = game_board[pos[0]][pos[1]]
      valids << pos unless tile.occupied?
      if tile.occupied? && tile.piece.color != current_player.color
        valids << pos
        break
      else
        break
      end
    end

    valids

  end

  private

  def change_current_player
    self.current_player = self.current_player == @player1 ? @player2 : @player1
  end
end

c = Chess.new
# c.set_players
# p c.player1.color
# p c.player2.color
# p c.current_player.color
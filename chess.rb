
require_relative 'humanplayer'

require_relative 'board'
require 'debugger'


class Chess

  DIAGONALS = (-7...8).
              to_a.map{ |row_coord| [row_coord, row_coord] } + (-7...8).
              to_a.map{ |row_coord| [row_coord, -row_coord] }

  HORIZONTALS = (-7...8).to_a.map{ |col_coord| [0, col_coord] }

  VERTICALS = (-7...8).to_a.map{ |row_coord| [row_coord, 0] }


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

 #   until win?
      turn
      turn
      turn
 #   end

 #   play_again?
  end

  def move
    request_coordinates = current_player.request_inputs
    origin = request_coordinates[0]
    destination = request_coordinates[1]
    chosen_tile = @game_board[origin[0], origin[1]]
    puts valid?(origin, destination, chosen_tile)
    make_move(origin, destination) if valid?(origin, destination, chosen_tile)
    puts @game_board.display_board
  end

  def turn
    move
    change_current_player
  end

  # METHODS RELATED TO MOVEMENT CALCULATION

  def make_move(origin, destination)
    temp = @game_board[origin[0]][origin[1]].piece.dup
    @game_board[destination[0]][destination[1]].piece = temp
    puts "Dest: #{@game_board[origin[0]][origin[1]].piece}"
    puts "Dest: #{@game_board[destination[0]][destination[1]].piece}"
    @game_board[origin[0]][origin[1]].piece = nil
  end

  def valid?(origin, destination, tile)

    if tile.piece != nil

      piece = tile.piece
      raw_possible_moves = piece.raw_possible_moves(origin)

      if valid_moves(raw_possible_moves, piece).include? (destination)
        return true
      end
    end
    false
  end

  def valid_moves(raw_possible_moves, piece)
    type = piece.type

    case type
    when 'Q'
      collision_check_vertical(piece) +
      collision_check_diagonal(piece) +
      collision_check_horizontal(piece) &
      raw_possible_moves
    when 'K'
      collision_check_vertical(piece) +
      collision_check_diagonal(piece) +
      collision_check_horizontal(piece) &
      raw_possible_moves
    when 'R'
      collision_check_vertical(piece) +
      collision_check_horizontal(piece) &
      raw_possible_moves
    when 'B'
      collision_check_diagonal(piece) &
      raw_possible_moves
    when 'p'
      # May work, need to add diagonals in pawn's constants
      # Took out diagonal call, correctly returns move
            debugger
      # collision_check_diagonal(piece) +
      collision_check_vertical(piece) & raw_possible_moves
    end
  end

  #Broke into directional collision_checks

  def collision_check_vertical (piece)

    valids = []

    current_row, current_col = piece.start_pos

    row = piece.start_pos[0] + 1

    until game_board[row,current_col].occupied? || !within_board?([row,current_col])
      tile = game_board[row,current_col]
      valids << [row,current_col] unless tile.occupied?
      row += 1
    end

    row = piece.start_pos[0] - 1

    until game_board[row,current_col].occupied? || !within_board?([row,current_col])
      tile = game_board[row,current_col]
      valids << [row,current_col] unless tile.occupied?
      row -= 1
    end

    valids
  end

  def collision_check_horizontal (piece)

    valids = []

    current_row, current_col = piece.start_pos

    col = piece.start_pos[1] + 1

    until game_board[current_row, col].occupied? || !within_board?([row,current_col])
      tile = game_board[row,current_col]
      valids << [row,current_col] unless tile.occupied?
      col += 1
    end

    col = piece.start_pos[1] - 1

    until game_board[current_row, col].occupied? || !within_board?([row,current_col])
      tile = game_board[row,current_col]
      valids << [row,current_col] unless tile.occupied?
      col -= 1
    end

    valids
  end

  def collision_check_diagonal (piece)

    valids = []

    current_row, current_col = piece.start_pos

    row = piece.start_pos[1] + 1
    col = piece.start_pos[1] + 1


    until game_board[current_row, col].occupied? || !within_board?([row,current_col])
      tile = game_board[row,col]
      valids << [row, col] unless tile.occupied?
      row += 1
      col += 1
    end

    row = piece.start_pos[1] - 1
    col = piece.start_pos[1] - 1

    until game_board[current_row, col].occupied? || !within_board?([row,current_col])
      tile = game_board[row,col]
      valids << [row,col] unless tile.occupied?
      row += 1
      col += 1
    end

    row = piece.start_pos[1] + 1
    col = piece.start_pos[1] - 1

    until game_board[current_row, col].occupied? || !within_board?([row,current_col])
      tile = game_board[row,col]
      valids << [row,col] unless tile.occupied?
      row += 1
      col -= 1
    end

    row = piece.start_pos[1] - 1
    col = piece.start_pos[1] + 1

    until game_board[current_row, col].occupied? || !within_board?([row,current_col])
      tile = game_board[row,col]
      valids << [row,col] unless tile.occupied?
      row -= 1
      col += 1

    end

    valids
  end

  def within_board?(possible_move)
    p "possible_move is  #{possible_move}"
    (0..7).to_a.include?(possible_move[0]) && (0..7).to_a.include?(possible_move[1])
  end

  private

  def change_current_player
    self.current_player = self.current_player == @player1 ? @player2 : @player1
  end
end

c = Chess.new
c.set_players
c.play
# c.set_players
# p c.player1.color
# p c.player2.color
# p c.current_player.color
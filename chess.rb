
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
    5.times {turn}
    5.times {turn}
  end

  def move
    puts @game_board.display_board
    request_coordinates = current_player.request_inputs
    origin = request_coordinates[0]
    destination = request_coordinates[1]
    chosen_tile = @game_board[origin[0], origin[1]]
    puts
    puts "return of valid: #{valid?(origin, destination, chosen_tile)}"
    valid?(origin, destination, chosen_tile) ? make_move(origin, destination) : move
  end

  def turn
    move
    change_current_player
  end

  # METHODS RELATED TO MOVEMENT CALCULATION

  def make_move(origin, destination)
    temp = @game_board[origin[0], origin[1]].piece.dup
    @game_board[destination[0], destination[1]].piece = temp
    @game_board[destination[0], destination[1]].piece.set_loc(destination)
    puts "Dest: #{@game_board[origin[0], origin[1]].piece}"
    puts "Should equal below: #{@game_board[destination[0], destination[1]].piece}"
    puts "New starting position is #{@game_board[destination[0], destination[1]].piece.start_pos}"
    @game_board[origin[0], origin[1]].piece = nil
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
      attack_moves = pawn_move(piece)
      p "attack_moves is: #{attack_moves}"
      p "diagonal check is: #{collision_check_diagonal(piece)}"
      p "vertical check is: #{collision_check_vertical(piece)}"
      p "raw moves is: #{raw_possible_moves}"
      (collision_check_diagonal(piece) + collision_check_vertical(piece)) &
      (raw_possible_moves + attack_moves)
    end

  end

  def pawn_move(piece)
    current_position = piece.start_pos

    color = piece.color

    attack_moves = piece.attack_increments.map do |x,y|
      [piece.start_pos[0] + x, piece.start_pos[1] + y]
    end

    attack_moves.select do |attack_move|
      within_board?(attack_move) &&
      game_board[attack_move[0], attack_move[1]].occupied_by_enemy?(color)
    end
  end
  #Broke into directional collision_checks

  def collision_check_vertical (piece)

    valids = []

    current_row, current_col = piece.start_pos

    color = piece.color

    row = piece.start_pos[0] + 1

    until !within_board?([row, current_col]) || game_board[row, current_col].occupied?
      tile = game_board[row,current_col]
      valids << [row,current_col]
      row += 1
      valids << [row,current_col] if within_board?([row,current_col]) && game_board[row,current_col].occupied_by_enemy?(color)
    end

    row = piece.start_pos[0] - 1

    until !within_board?([row, current_col]) || game_board[row, current_col].occupied?
      tile = game_board[row,current_col]
      valids << [row,current_col]
      row -= 1
      valids << [row,current_col] if within_board?([row,current_col]) && game_board[row,current_col].occupied_by_enemy?(color)
    end

    valids
  end

  def collision_check_horizontal (piece)

    valids = []

    current_row, current_col = piece.start_pos

    color = piece.color

    col = piece.start_pos[1] + 1

    until !within_board?([current_row,col]) || game_board[current_row, col].occupied?
      tile = game_board[current_row,col]
      valids << [current_row,col] unless tile.occupied?
      col += 1
      valids << [current_row,col] if within_board?([current_row,col]) && game_board[current_row,col].occupied_by_enemy?(color)
    end


    col = piece.start_pos[1] - 1

    until !within_board?([current_row,col]) || game_board[current_row, col].occupied?
      tile = game_board[current_row,col]
      valids << [current_row,col] unless tile.occupied?
      col -= 1
      valids << [current_row,col] if within_board?([current_row,col]) && game_board[current_row,col].occupied_by_enemy?(color)
    end

    valids
  end

  def collision_check_diagonal (piece)

    valids = []

    color = piece.color

    row = piece.start_pos[0] + 1
    col = piece.start_pos[1] + 1

    if within_board?([row,col])
      if game_board[row,col].occupied_by_enemy?(color)
        valids << [row,col]
      end
    end


    until !within_board?([row,col]) || game_board[row, col].occupied?
      tile = game_board[row,col]
      valids << [row, col]
      row += 1
      col += 1
      if within_board?([row,col])
        if game_board[row,col].occupied_by_enemy?(color)
          valids << [row,col]
        end
      end
    end

    row = piece.start_pos[0] - 1
    col = piece.start_pos[1] - 1

    if within_board?([row,col])
      if game_board[row,col].occupied_by_enemy?(color)
        valids << [row,col]
      end
    end

    until !within_board?([row,col]) || game_board[row, col].occupied?
      tile = game_board[row,col]
      valids << [row,col]
      row -= 1
      col -= 1
      if within_board?([row,col])
        if game_board[row,col].occupied_by_enemy?(color)
          valids << [row,col]
        end
      end
    end

    row = piece.start_pos[0] + 1
    col = piece.start_pos[1] - 1

    if within_board?([row,col])
      if game_board[row,col].occupied_by_enemy?(color)
        valids << [row,col]
      end
    end

    until !within_board?([row,col]) || game_board[row, col].occupied?
      tile = game_board[row,col]
      valids << [row,col]
      row += 1
      col -= 1
      if within_board?([row,col])
        if game_board[row,col].occupied_by_enemy?(color)
          valids << [row,col]
        end
      end
    end

    row = piece.start_pos[0] - 1
    col = piece.start_pos[1] + 1

    if within_board?([row,col])
      if game_board[row,col].occupied_by_enemy?(color)
        valids << [row,col]
      end
    end

    until !within_board?([row,col]) || game_board[row, col].occupied?
      tile = game_board[row,col]
      valids << [row,col]
      row -= 1
      col += 1
      if within_board?([row,col])
        if game_board[row,col].occupied_by_enemy?(color)
          valids << [row,col]
        end
      end
    end

    valids
  end

  def within_board?(possible_move)
    #p "possible_move is  #{possible_move}"
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
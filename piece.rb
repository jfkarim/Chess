
class Piece

  DIAGONALS = (-7...8).
              to_a.map{ |row_coord| [row_coord, row_coord] } + (-7...8).
              to_a.map{ |row_coord| [row_coord, -row_coord] }

  HORIZONTALS = (-7...8).to_a.map{ |col_coord| [0, col_coord] }

  VERTICALS = (-7...8).to_a.map{ |row_coord| [row_coord, 0] }

  attr_accessor :type, :start_pos, :move_increments, :color, :moved

  def initialize(type, start_pos, move_increments, color=nil)
    self.type = type #Symbol used to refer to piece on the board
    self.start_pos = start_pos
    self.move_increments = move_increments #array of possible moves, i.e.,
    self.moved = false
    self.color = color
  end

  def set_loc(pos)
    self.start_pos = pos
  end

  # def moved?
  #   self.moved
  # end
  #
  # def =moved?(boolean)
  #   self.moved? = boolean
  # end

  def raw_possible_moves(start_pos)
    raw_possible_moves = []

    current_row, current_col = start_pos

    self.move_increments.each do |(d_row, d_col)|

      possible_move = [current_row + d_row, current_col + d_col]

      raw_possible_moves << possible_move if within_board?(possible_move)
      #need to check if pieces in way, pos move on board, and if king check
    end
    raw_possible_moves
  end

  def within_board?(possible_move)
    (0..7).to_a.include?(possible_move[0]) && (0..7).to_a.include?(possible_move[1])
  end

end
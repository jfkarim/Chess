class Piece

  attr_accessor :type, :start_pos, :move_possibilities, :color

  def initialize(type, start_pos, move_possibilities, color=nil)
    self.type = type #Symbol used to refer to piece on the board
    self.start_pos = start_pos
    self.move_increments = move_increments #array of possible moves, i.e.,
    self.moved = false
  end

  def moved?
    self.moved
  end

  def =moved?(boolean)
    self.moved? = boolean
  end

  def raw_possible_moves(start_pos)
    raw_possible_moves = []

    current_row, current_col = start_pos

    move_increments.each do |(d_row, d_col)|

      possible_move = [current_row + d_row, current_col + d_col]

      raw_possible_moves << new_pos
      #need to check if pieces in way, pos move on board, and if king check
    end

    valid_moves
  end


end
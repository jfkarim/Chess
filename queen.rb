
require_relative 'piece'


class Queen < Piece

  DIAGONALS = (-7...8).
              to_a.map{ |row_coord| [row_coord, row_coord] } + (-7...8).
              to_a.map{ |row_coord| [row_coord, -row_coord] }

  HORIZONTALS = (-7...8).to_a.map{ |col_coord| [0, col_coord] }

  VERTICALS = (-7...8).to_a.map{ |row_coord| [row_coord, 0] }

  MOVE_INCREMENT =  DIAGONALS + HORIZONTALS + VERTICALS

  def initialize (start_pos, color=nil)
    super("Q", start_pos, MOVE_INCREMENT, color)
  end

end

q = Queen.new([0,0], 'white')

p moves = q.raw_possible_moves(q.start_pos)


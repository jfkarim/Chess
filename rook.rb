require_relative 'piece'

class Rook < Piece

  MOVE_INCREMENT = (-7...8).
                    to_a.map{|x_coord| [x_coord, 0]} + (-7...8).
                    to_a.map{|y_coord| [0, y_coord]}.delete([0,0])

  def initialize (start_pos, color=nil)
    super("R", start_pos, MOVE_INCREMENT, color=nil)
  end

end

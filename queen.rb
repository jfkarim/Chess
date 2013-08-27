require_relative 'piece'

class Queen < Piece

  MOVE_INCREMENT = (-7...8).
                    to_a.map{|x_coord| [x_coord, x_coord]} + (-7...8).
                    to_a.map{|x_coord| [x_coord, -x_coord]} + (-7...8).
                    to_a.map{|x_coord| [x_coord, 0]} + (-7...8).
                    to_a.map{|y_coord| [0, y_coord]}.delete([0,0])

  def initialize (start_pos, color=nil)
    super("Q", start_pos, MOVE_INCREMENT, color)
  end

end
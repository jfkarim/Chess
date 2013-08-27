require_relative 'piece'

class Bishop < Piece

  MOVE_INCREMENT = (-7...8).to_a.
                  map{|x_coord| [x_coord, x_coord]} + (-7...8).
                  to_a.map{|x_coord| [x_coord, -x_coord]}

  def initialize (start_pos, color=nil)
    super("B", start_pos, MOVE_INCREMENT, color=nil)
  end

end
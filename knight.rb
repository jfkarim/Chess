require_relative 'piece'

class Knight < Piece

  MOVE_INCREMENT =  [[-2,-1], [-2,1], [-1,-2], [-1,2],
                    [1,-2], [1,2], [2,-1], [2,1]]

  def initialize (start_pos, color=nil)
    super("N", start_pos, MOVE_INCREMENT, color=nil)
  end

end

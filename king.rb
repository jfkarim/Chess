require_relative 'piece'

class King < Piece

  MOVE_INCREMENT = [[1,0], [1,1], [1,-1], [0,1],
                    [0,-1], [-1,0], [-1,-1], [-1,1]]

  def initialize (start_pos, color=nil)
    super("K", start_pos, MOVE_INCREMENT, color=nil)
  end

end
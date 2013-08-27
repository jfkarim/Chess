require_relative 'piece'

class Pawn < Piece

  MOVE_INCREMENT = [[0,1]]

  def initialize (start_pos, color=nil)
    super("p", start_pos, MOVE_INCREMENT, color)
  end

end

class Pawn < Piece

  MOVE_INCREMENT = [[0,1]]

  def initialize (type, start_pos, move_possibilities, color=nil)
    super("p", start_pos, MOVE_INCREMENT, color=nil)
    self.moved = false
  end



end

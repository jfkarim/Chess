require_relative 'piece'



class Pawn < Piece

  MOVE_INCREMENT = [[1,0], [-1,0]]
  #Might want to add diagonals for attack and filter later

  def initialize (start_pos, color=nil)
    super("p", start_pos, MOVE_INCREMENT, color)
  end

end

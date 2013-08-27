class Piece



  def initialize(type, start_pos, move_possibility, color=nil)
    self.type = type #Symbol used to refer to piece on the board
    self.start_pos = start_pos
    self.move_possibility = move_possibility
  end


end
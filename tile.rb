
class Tile
  attr_accessor :piece

  def initialize(piece = nil)
    self.piece = piece
  end


  def occupied?
    return !piece.nil?
  end

  def occupied_by_who
    if occupied?
      piece.type
    end
  end


end
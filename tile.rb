
class Tile
  attr_accessor :piece

  def initialize(piece = nil)
    self.piece = piece
  end


  def occupied?
    return !piece.nil?
  end

  def occupied_by_enemy?(color)
    return false if piece.nil?
    piece.color != color
  end

  def occupied_by_teammate?(color)
    return false if piece.nil?
    piece.color == color
  end

end
class Tile
  attr_accessor :piece

  def initialize(piece = nil)
    self.piece = piece
  end

  def occupied_by_who
    #see's who's on the tile
    piece.color
    piece.type
  end

end
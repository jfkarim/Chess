class Tile
  attr_accessor :piece

  def initialize(piece = nil)

  end

  def occupied_by_who
    #see's who's on the tile
    piece.color
    piece.type
  end

end
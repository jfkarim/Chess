require_relative 'piece'



class Pawn < Piece

  attr_accessor :move_increments, :attack_increments

  #Might want to add diagonals for attack and filter later

  def initialize (start_pos, color=nil)
    super("p", start_pos, nil,color)

    if self.color == 'black'
      self.move_increments = [[-1,0]]
      self.attack_increments = [[-1,1],[-1,-1]]
    elsif self.color == 'white'
      self.move_increments = [[1,0]]
      self.attack_increments = [[1,1],[1,-1]]
    end

  end


end

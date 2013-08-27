class HumanPlayer #< Player

  attr_accessor :name, :attr_reader, :color

  def initialize (color = nil)
    self.name = get_name
    self.color = color
  end

  def get_name
    puts "Please input your name:"
    gets.chomp.downcase.capitalize
  end

  def color_choice
    puts "Which color would you like to play as (black or white...not your race)?"
    input = gets.chomp
    input =~ /black|white/i ? input : color_choice # if doesn't work, use color_choice
  end

  def request_inputs
    [get_origin, get_destination]
  end

  def get_origin
    puts "Where would you like to move your piece from?"
    origin = gets.chomp
    origin =~ /[1-8],[1-8]/ ? origin = origin.split(',') : get_origin
  end

  def get_destination
    puts "Where would you like to move to?"
    destination = gets.chomp
    destination =~ /[1-8],[1-8]/ ? destination = destination.split(',') : get_destination
  end

end

h = HumanPlayer.new
h.get_origin
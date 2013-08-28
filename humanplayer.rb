
class HumanPlayer #< Player

  attr_accessor :name, :attr_reader, :color, :grid_hash

  def initialize (color = nil)
    self.name = get_name
    self.color = color
    self.grid_hash = create_grid_hash
  end


  def create_grid_hash
    keys = (("A".."H").to_a * 8).sort.zip((1..8).to_a * 8).map { |key| key.join('') }

    vals = (0...8).to_a.each_with_object([]) do | index1, array |
      8.times do |index2| array << [index1, index2]
      end
    end
    return Hash[keys.zip(vals)]
  end


  def get_name
    puts "Please input your name:"
    gets.chomp.downcase.capitalize
  end

  def color_choice
    puts "#{name}, Which color would you like to play as (black or white...not your race)?"
    input = gets.chomp
    input =~ /black|white/i ? input : color_choice # if doesn't work, use color_choice
  end

  def request_inputs
    [get_origin, get_destination]
  end

  def get_origin
    puts "#{name}, Where would you like to move your piece from?"
    coord = gets.chomp.upcase
    coord =~ /[A-H][1-8]/ ? grid_hash[coord] : get_origin
  end

  def get_destination
    puts "#{name}, Where would you like to move to?"
    coord = gets.chomp.upcase
    coord =~ /[A-H][1-8]/ ? grid_hash[coord] : get_destination
  end

end

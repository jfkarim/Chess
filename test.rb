keys = (("A".."H").to_a * 8).sort.zip((1..8).to_a * 8).map { |key| key.join('') }

vals = (0...8).to_a.each_with_object([]) do | index1, array |
  8.times do |index2| array << [index1, index2]
    end
  end

  p Hash[keys.zip(vals)]
=begin

Problem:

As you continue your walk, the Elf poses a second question: 
in each game you played, what is the fewest number of cubes of each color 
that could have been in the bag to make the game possible?

Again consider the example games from earlier:

Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green

In game 1, the game could have been played with as few as 4 red, 2 green, and 6 blue cubes. 
If any color had even one fewer cube, the game would have been impossible.
Game 2 could have been played with a minimum of 1 red, 3 green, and 4 blue cubes.
Game 3 must have been played with at least 20 red, 13 green, and 6 blue cubes.
Game 4 required at least 14 red, 3 green, and 15 blue cubes.
Game 5 needed no fewer than 6 red, 3 green, and 2 blue cubes in the bag.
The power of a set of cubes is equal to the numbers of red, green, and blue cubes multiplied together. 
The power of the minimum set of cubes in game 1 is 48. In games 2-5 it was 12, 1560, 630, and 36, respectively. 
Adding up these five powers produces the sum 2286.

For each game, find the minimum set of cubes that must have been present. 
What is the sum of the power of these sets?

Algorithm:
 - Mental model:
   -For each color find the greatest count (red, green blue)
   - return the factor (high_red * high_green * high_blue)


=end

def total_power
  sum = 0
  path = './day_two_input.txt'
  File.open(path).each_line do |line|
    line_to_string = ""
    line_to_string += line
    sum += min_num_power(line_to_string)
  end
  return sum
end

def min_num_power(str)
  game_str = str.split(':').last
  game_str.lstrip!
  game_arr = game_str.split('; ') 
  set_arr = []
  game_arr.each do |set|
    set_arr << set.split(', ')
  end
  color_arr = []
  set_arr.each do |set|
    set.each do |color|
    color_arr << color.split(' ')
    end
  end

  high_count = {}

  color_arr.each do |set|
    if high_count.include?(set.last.to_sym)
      if set.first.to_i > high_count[set.last.to_sym]
        high_count[set.last.to_sym] = set.first.to_i
      end
    else
      high_count[set.last.to_sym] = set.first.to_i
    end
  end

  total_factor = 1
  max_values = high_count.values
  max_values.each { |num| total_factor *= num }

  return total_factor

end

p total_power
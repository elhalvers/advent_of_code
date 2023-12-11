=begin
  PEDAC
  Problem:
    The Elf shows you a small bag and some cubes which are either red, green, or blue. 
    Each time you play this game, he will hide a secret number of cubes of each color in the bag, 
    and your goal is to figure out information about the number of cubes.

    To get information, once a bag has been loaded with cubes, the Elf will reach into the bag, 
    grab a handful of random cubes, show them to you, and then put them back in the bag. He'll do this a few times per game.

    You play several games and record the information from each game (your puzzle input). 
    Each game is listed with its ID number (like the 11 in Game 11: ...) followed by 
    a semicolon-separated list of subsets of cubes that were revealed from the bag (like 3 red, 5 green, 4 blue).

    For example, the record of a few games might look like this:

    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green

    The Elf would first like to know which games would have been possible if the bag contained 
    only 12 red cubes, 13 green cubes, and 14 blue cubes?

    In the example above, games 1, 2, and 5 would have been possible if the bag had been loaded with that configuration. 
    However, game 3 would have been impossible because at one point the Elf showed you 20 red cubes at once; 
    similarly, game 4 would also have been impossible because the Elf showed you 15 blue cubes at once. 
    If you add up the IDs of the games that would have been possible, you get 8.

    Determine which games would have been possible if the bag had been loaded with only 
    12 red cubes, 13 green cubes, and 14 blue cubes. 

    Input: 
    - text file. Each line is a game. The game_id is the integer following Game at the beginning of each line.
    - Each game has a few sets separated by semicolons.
    - There is not an ending semicolon
    - each set has a number of red, green and or blue cubes. 
      The integer before the color represents the number of cubes of that color in that set.
    - each color is separated by a comma (see 'Examples' below)

    Output: An integer representing the sum of the Game ID's where the game would be possible based on the set limits:
    if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes

    Rules:
    Mental Model:
    - 


  Examples:
   Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
   Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
   Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
   Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
   Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green

   In game 1, three sets of cubes are revealed from the bag (and then put back again). 
   The first set is 3 blue cubes and 4 red cubes; 
   the second set is 1 red cube, 2 green cubes, and 6 blue cubes; 
   the third set is only 2 green cubes.

  DS:
  - Input text line converted to String
  - Output is an Integer
  - Intermediate: Array - At first to separate string based on space, comma or semicolon.
   - Will probably use a hash for key value pairs (color: count)

  Algorithm: (Outer Method)
  1. Set up a sum variable initialized to 0
  2. Read the lines from the input text file and for each line,
     convert line to a String
  3. Add the value returned by the valid_game_score helper method to the running total.
  4. Return the total 'sum'

=end

def cube_game_sum
  sum = 0
    path = './day_two_input.txt'
    File.open(path).each_line do |line|
      line_to_string = ""
      line_to_string += line
      sum += valid_game_score(line_to_string)
    end
  return sum
end


=begin
  Rules:
   - Each line_string represents one complete game and has a unique Game ID as an Integer
   - Each game has several sets separated by semi-colons

  Algorithm: (helper method(s))
  - High Level
    1. Take the line_string as an argument
    2. Separate the Game ID and all of the sets within each game.
    3. For each set,
        - Check to see if the number of red, green and blue cubes are less than or equal
        to the limits (valid)
    4. If ALL of the sets are valid (less than or equal), return the Game ID Integer for that game (line_str)

  - Mid Level
    1. Take the line_string as an argument
    2. Separate the Game ID and all of the sets within each game.
      - 
    3. For each set,
        - Check to see if the number of red, green and blue cubes are valid.
    4. If ALL of the sets are valid, return the Game ID Integer for that game (line_str)

=end

LIMIT_HASH = { red: 12, green: 13, blue: 14 }

def valid_game_score(str)
  game_id= str.split(':').first
  game_num = game_id.split(' ').last.to_i

  if game_valid?(str)
    return game_num
  else
    return 0
  end
end

def game_valid?(str)
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

  color_arr.each do |set|
    if set.first.to_i > LIMIT_HASH[set.last.to_sym]
      return false
    end
  end
  return true
end

puts cube_game_sum

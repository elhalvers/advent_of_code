=begin
  
--- Day One, Part Two ---
Your calculation isn't quite right. It looks like some of the digits are actually spelled out with letters: 
one, two, three, four, five, six, seven, eight, and nine also count as valid "digits".

Equipped with this new information, you now need to find the real first and last digit on each line. For example:

two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
In this example, the calibration values are 29, 83, 13, 24, 42, 14, and 76. Adding these together produces 281.

What is the sum of all of the calibration values?

PEDAC

P: 
 - Given a set of strings, one string per line, for each string, find the first and last digit (concatenate)
  and then sum up each 2 digit number and return the sum.

  Input: a text file of multiple lines. Each line consists of plain text including letters and numbers (not strings)
  Output: An integer representing the sum of the 2 digit numbers collected from the first and last digit in each string.

  Rules:
  - Some of the digits are actually spelled out with letters: 
    one, two, three, four, five, six, seven, eight, and nine also count as valid "digits".
  * Based on the 'treb7uchet' example, which returns 77, if there is only one digit, you should return that digit repeated.
  * Not sure if there is at least 1 digit in every string.

  Mental Model:
  -
E:
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen

In this example, the calibration values are 29, 83, 13, 24, 42, 14, and 76. Adding these together produces 281.

DS: input ds is a string.
    output is an integer
    

A: Mental Model: (Top method is unchanged for part 2 of the problem. Need to refactor the helper method for part 2 requirements)
   - Top Method (sum_calibration_values):
   1. Create an empty sum variable
   2. parse each line in the input text file, for each line,
        a. convert the line to a string
        b. call helper method to convert string to integer
        c. add return value of helper method to running sum variable
   3. Return sum


=end

def sum_calibration_values
  sum = 0
    path = './day_one_input.txt'
    File.open(path).each_line do |line|
      line_to_string = ""
      line_to_string += line
      sum += calibration_conversion(line_to_string)
    end
  return sum
end

=begin

 -For part 2, Need to modify the helper method to include new requirements:
 PEDAC
 P:
  Rules:
  - Some of the digits are actually spelled out with letters: 
    one, two, three, four, five, six, seven, eight, and nine also count as valid "digits".
    * Based on a couple of the examples:
     (eightwothree, zoneight234) for first example, consider 'eight' but not 'two', second, consider 'one' but not 'eight'
      - In other words, the earlier indexed string_num has a higher priority since we are tracking first and last

  E:
  two1nine # => 29
  eightwothree # => 83
  abcone2threexyz # => 13
  xtwone3four # => 24
  4nineeightseven2 # => 42
  zoneight234 # => 14
  7pqrstsixteen # => 76

  In this example, the calibration values are 29, 83, 13, 24, 42, 14, and 76. Adding these together produces 281.

  DS: Strings, Arrays?

  A: Mental model:
   - In addition to the original 'digits' list,
     will need to evaluate substrings based on a list of spelled out nums ('one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine')
     and convert those substrings to a string based number ('1', '2','3', etc...)
  - substitute '1' for 'one', '2', for 'two', etc...
  - Based on a couple of the examples:
     (eightwothree, zoneight234) for first example, consider 'eight' but not 'two', second, consider 'one' but not 'eight'
  -  create a sorted list of all digits, string numbers and spelled out digits - sorted by index. Choose the first and last index.
  - convert 'one' to '1', etc... as necessary and then concatenate and convert to integer
E:
  two1nine # => 29
  eightwothree # => 83
  abcone2threexyz # => 13
  xtwone3four # => 24
  4nineeightseven2 # => 42
  zoneight234 # => 14
  7pqrstsixteen # => 76

  Algorithm:
  1. initialize variables as digits '0123456789', add arr_num_str as %w(one two three four five six seven eight nine)
  2. initialize an empty arr of indexes and digits 'arr_num_indexes'
  4. iterate over each character in the string
       - if digits include the char
           append the empty array with the index and char
  5. iterate over the array of string numbers (arr_num_str)
     if the string includes the string number
       append the num_index array with the index and num.
  6. Sort the num_indexes array.
  7. Retrieve the first and last sub_arrays from the sorted array.
  8. Remove the indexes leaving an array of num_strings
  9. 

=end

def calibration_conversion(str) # helper method
  all_nums = ''
  digits = '0123456789'
  arr_num_str = %w(one two three four five six seven eight nine)
  arr_num_indexes = []

  str.each_char do |char|
    if digits.include?(char)
      arr_num_indexes << [str.index(char), char]
      arr_num_indexes << [str.rindex(char), char]
    end
  end
  arr_num_str.each_with_index do |num, index|
    if str.include?(num)
      arr_num_indexes << [str.index(num), num]
      arr_num_indexes << [str.rindex(num), num]
    end
  end

  arr_num_indexes.sort!
  first_last = arr_num_indexes.first + arr_num_indexes.last
  two_nums = first_last.select! { |el| el.is_a?(String) }

  two_nums.each do |num|
    if arr_num_str.include?(num)
      case num
      when 'one' then all_nums += '1'
      when 'two' then all_nums += '2'
      when 'three' then all_nums += '3'
      when 'four' then all_nums += '4'
      when 'five' then all_nums += '5'
      when 'six' then all_nums += '6'
      when 'seven' then all_nums += '7'
      when 'eight' then all_nums += '8'
      when 'nine' then all_nums += '9'
      end
    else all_nums += num
    end
  end
  return all_nums.to_i
end

# Tests


puts sum_calibration_values
#puts calibration_conversion('eight9fhstbssrplmdlncmmqqnklb39ninejz')
#puts calibration_conversion('three656')
# puts calibration_conversion('ppjvndvknbtpfsncplmhhrlh5')
# puts calibration_conversion('7fjqhrhsevenlbtwoninevnmct2')
# puts calibration_conversion('qjnbpfrztwo1')
# puts calibration_conversion('plggqjthree49four')
# puts calibration_conversion('xpxpbsdc1')
# puts calibration_conversion('three2six8two5')
# puts calibration_conversion('36two')
# puts calibration_conversion('five121zvjks3')

# eight9fhstbssrplmdlncmmqqnklb39ninejz => 89
# three656 => 36
# ppjvndvknbtpfsncplmhhrlh5 => 55
# 7fjqhrhsevenlbtwoninevnmct2 => 72
# qjnbpfrztwo1 => 21
# plggqjthree49four => 34
# xpxpbsdc1 => 11
# three2six8two5 => 35
# 36two => 32
# five121zvjks3 => 53

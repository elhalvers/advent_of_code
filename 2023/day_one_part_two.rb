=begin
  
--- Day One, Part Two ---
Your calculation isn't quite right. It looks like some of the digits are actually spelled out with letters: one, two, three, four, five, six, seven, eight, and nine also count as valid "digits".

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

P: Given a set of strings, one string per line, for each string, find the first and last digit (concatenate)
and then sum up each 2 digit number and return the sum.
  Input: several strings containing letters and numbers, each separated by a new line
  Output: An integer representing the sum of the 2 digit numbers collected from the first and last digit in each string.
  Rules:
  * Based on the 'treb7uchet' example, which returns 77, if there is only one digit, you should return that digit repeated.
  * Not sure if there is at least 1 digit in every string.
E:
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet

In this example, the calibration values of these four lines are 12, 38, 15, and 77. Adding these together produces 142.

DS: starting ds is a string. Thinking of using an array as an intermediate data structure, but may not be necessary.

A: Mental Model:
   - General:
   1. parse each line in the input text file, for each line,
        convert the line to a string
        remove the non 'digit' characters, either via regex or using a list (1234567890) preserving the char order
        concatenate the first and last value
        convert it to an integer
        add to a total variable


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
 

=end

def calibration_conversion(str) # helper method
  all_nums = ''
  digits = '0123456789'
  str.each_char do |char|
    if digits.include?(char)
      all_nums << char
    end
  end

  two_nums = (all_nums[0] + all_nums[-1]).to_i
  return two_nums
end


puts sum_calibration_values


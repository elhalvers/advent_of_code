=begin
  
--- Day 1: Trebuchet?! ---
Something is wrong with global snow production, and you've been selected to take a look. 
The Elves have even given you a map; on it, they've used stars to mark the top fifty locations 
that are likely to be having problems.

You've been doing this long enough to know that to restore snow operations, you need to check all fifty stars by December 25th.

Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; 
the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

You try to ask why they can't just use a weather machine ("not powerful enough") and where they're even 
sending you ("the sky") and why your map looks mostly blank ("you sure ask a lot of questions") and hang on 
did you just say the sky ("of course, where do you think snow comes from") when you realize that the Elves are 
  already loading you into a trebuchet ("please hold still, we need to strap you in").

As they're making the final adjustments, they discover that their calibration document (your puzzle input) 
has been amended by a very young Elf who was apparently just excited to show off her art skills. 
Consequently, the Elves are having trouble reading the values on the document.

The newly-improved calibration document consists of lines of text; each line originally contained 
a specific calibration value that the Elves now need to recover. On each line, the calibration value 
can be found by combining the first digit and the last digit (in that order) to form a single two-digit number.

For example:

1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet

In this example, the calibration values of these four lines are 12, 38, 15, and 77. Adding these together produces 142.

Consider your entire calibration document. What is the sum of all of the calibration values?

PEDAC

P: Given a set of strings, one string per line, for each string, find the first and last digit (string integer) (concatenate)
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


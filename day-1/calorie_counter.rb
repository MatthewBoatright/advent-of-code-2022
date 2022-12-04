def process_input(input)
  res = []

  cur = []
  File.foreach(input) do |line|
    if line == "\n"
      res << cur
      cur = []
    else
      cur << line.to_i
    end
  end

  res << cur
end

def count_max_calories(calories_by_elf, limit)
  max_calories = Array.new(limit, 0)

  calories_by_elf.each do |calories|
    sum = calories.sum
    max_calories[0] = sum if sum > max_calories[0]
    max_calories.sort!
  end

  max_calories.sum
end

if ARGV.length < 1
  puts "Usage: ruby calorie_counter.rb <input_file>"
  exit 1
end

input = ARGV[0]
calories_by_elf = process_input(input)

puts count_max_calories(calories_by_elf, 1)
puts count_max_calories(calories_by_elf, 3)
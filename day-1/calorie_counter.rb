DEFAULT_LIMIT = 3

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
  puts "Usage: ruby calorie_counter.rb <input_file> [<limit>]"
  exit 1
end

input = ARGV[0]
limit = ARGV.length > 1 ? ARGV[1].to_i : DEFAULT_LIMIT

calories_by_elf = process_input(input)
max_calories = count_max_calories(calories_by_elf, limit)

puts max_calories
DEFAULT_LIMIT = 3

def count_max_calories(input, limit)
  puts "Opening input file: #{input}"

  max_calories = Array.new(limit, 0)
  cur_calories = 0
  File.foreach(input) do |line|
    if line == "\n"
      max_calories[0] = cur_calories if cur_calories > max_calories.first
      max_calories.sort!

      cur_calories = 0
    else
      cur_calories += line.to_i
    end
  end

  max_calories[0] = cur_calories if cur_calories > max_calories.first
  max_calories.sum
end

if ARGV.length < 1
  puts "Usage: ruby calorie_counter.rb <input_file> [<limit>]"
  exit 1
end

input = ARGV[0]
limit = ARGV.length > 1 ? ARGV[1].to_i : DEFAULT_LIMIT
puts count_max_calories(input, limit)
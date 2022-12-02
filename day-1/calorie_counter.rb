def count_max_calories(input)
  puts "Opening input file: #{input}"

  max_calories = 0
  cur_calories = 0
  File.foreach(input) do |line|
    if line == "\n"
      max_calories = [max_calories, cur_calories].max
      cur_calories = 0
    else
      cur_calories += line.to_i
    end
  end

  [max_calories, cur_calories].max
end

if ARGV.length != 1
  puts "Please provide the filename for the text input."
  exit 1
end

puts count_max_calories(ARGV.first)
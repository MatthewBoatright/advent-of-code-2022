def process_input(input)
  res = []

  File.foreach(input) do |line|
    line = line.strip.split(",")
    pair = line.map{ |p| p.split("-") }
    
    ranges = []
    ranges << Range.new(pair[0][0], pair[0][1])
    ranges << Range.new(pair[1][0], pair[1][1])

    res << ranges
  end

  res
end

def count_fully_contained_assignments(assignments)
  fully_contained_assignments = 0

  assignments.each do |assignment|
    a, b = assignment[0].to_a, assignment[1].to_a

    intersection = a & b

    fully_contained_assignments += 1 if intersection == a || intersection == b
  end

  fully_contained_assignments
end

if ARGV.length < 1
  puts "Usage: ruby cleanup_scheduler.rb <input_file>"
  exit 1
end

input = ARGV[0]
assignments = process_input(input)

puts count_fully_contained_assignments(assignments)
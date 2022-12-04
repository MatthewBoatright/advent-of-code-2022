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

def count_fully_contained_tasks(task_pairs)
  fully_contained_tasks = 0

  task_pairs.each do |task_pair|
    a, b = task_pair[0].to_a, task_pair[1].to_a

    intersection = a & b

    fully_contained_tasks += 1 if intersection == a || intersection == b
  end

  fully_contained_tasks
end

def count_overlapping_tasks(task_pairs)
  overlapping_tasks = 0

  task_pairs.each do |task_pair|
    a, b = task_pair[0].to_a, task_pair[1].to_a

    intersection = a & b

    overlapping_tasks += 1 unless intersection.empty?
  end

  overlapping_tasks
end

if ARGV.length < 1
  puts "Usage: ruby cleanup_scheduler.rb <input_file>"
  exit 1
end

input = ARGV[0]
task_pairs = process_input(input)

puts count_fully_contained_tasks(task_pairs)
puts count_overlapping_tasks(task_pairs)
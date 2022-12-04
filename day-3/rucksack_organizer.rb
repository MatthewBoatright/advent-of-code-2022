require "set"

ITEM_PRIORITIES = ([nil] << ("a".."z").to_a << ("A".."Z").to_a).flatten

def process_input(input)
  res = []

  File.foreach(input) do |line|
    chars = line.strip.chars
    len = line.length
    
    res << [chars[0..len/2], chars[len/2..-1]]
  end

  res
end

def priority_sum_of_common_items(rucksacks)
  sum = 0

  rucksacks.each do |rucksack|
    a, b = rucksack[0], rucksack[1]

    common_item = (a & b).first
    item_priority = ITEM_PRIORITIES.index(common_item)
    sum += item_priority
  end

  sum
end

def priority_sum_of_group_items(rucksacks)
  sum = 0
  len = rucksacks.length

  (len / 3).times do |group|
    a, b, c = rucksacks.slice((group * 3), 3).map(&:flatten).map(&:to_set)
    
    common_group_item = (a & b & c).first
    item_priority = ITEM_PRIORITIES.index(common_group_item)
    sum += item_priority
  end

  sum
end

if ARGV.length < 1
  puts "Usage: ruby rucksack_organizer.rb <input_file>"
  exit 1
end

input = ARGV[0]
rucksacks = process_input(input)

puts priority_sum_of_common_items(rucksacks)
puts priority_sum_of_group_items(rucksacks)
require "set"

ITEM_PRIORITIES = ([nil] << ("a".."z").to_a << ("A".."Z").to_a).flatten

def process_input(input)
  res = []

  File.foreach(input) do |line|
    chars = line.chars
    len = line.length
    
    res << [chars[0..len/2], chars[len/2..-1]]
  end

  res
end

def priority_sum_of_common_items(rucksacks)
  sum = 0

  rucksacks.each do |rucksack|
    common_item = find_common_item(rucksack)
    item_priority = ITEM_PRIORITIES.index(common_item)
    sum += item_priority

    puts "Common item; '#{common_item}'. Priority; '#{item_priority}'"
  end

  sum
end

def find_common_item(rucksack)
  compartment_length = rucksack[0].length
  first_compartment, second_compartment = rucksack[0], rucksack[1]
  first_compartment_items, second_compartment_items = Set.new, Set.new

  compartment_length.times do |i|
    a, b = first_compartment[i], second_compartment[i]
    first_compartment_items.add(a)
    second_compartment_items.add(b)

    return a if second_compartment_items.include?(a)
    return b if first_compartment_items.include?(b)
  end

  nil
end

if ARGV.length < 1
  puts "Usage: ruby rucksack_organizer.rb <input_file>"
  exit 1
end

input = ARGV[0]
rucksacks = process_input(input)
priority_sum = priority_sum_of_common_items(rucksacks)

puts priority_sum
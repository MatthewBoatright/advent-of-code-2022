# TOP => BOTTOM
STACKS = [
  %w(N W B),
  %w(B M D T P S Z L),
  %w(R W Z H Q),
  %w(R Z J V D W),
  %w(B M H S),
  %w(B P V H J N G L),
  %w(S L D H F Z Q J),
  %w(B Q G J F S W),
  %w(J D C S M W Z),
]

def process_input(input)
  res = []

  File.foreach(input) do |line|
    next unless line.start_with? "move"

    cur = line.scan(/\d+/).map(&:to_i)
    cur[1] -= 1
    cur[2] -= 1

    res << cur
  end

  res
end

def rearrange_stacks(procedure)
  procedure.each do |qty, from, to|
    crates = STACKS[from].shift(qty)
    #crates.reverse! #Uncomment if using CrateMover 9000.
    next if crates == nil

    STACKS[to] = crates + STACKS[to]
  end
end

if ARGV.length < 1
  puts "Usage: ruby crate_stacks.rb <input_file>"
  exit 1
end

input = ARGV[0]
rearrangement_procedure = process_input(input)
rearrange_stacks(rearrangement_procedure)

puts STACKS.map(&:first).join("")
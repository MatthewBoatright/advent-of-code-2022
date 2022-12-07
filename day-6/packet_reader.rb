if ARGV.length < 1
  puts "Usage: ruby packet_reader.rb <input_file>"
  exit 1
end

def find_start_of_packet_market_index(stream)
  chars = stream.chars

  0.upto(stream.length - 4) do |i|
    slice = chars.slice(i, 4)
    next if slice.uniq.length < 4

    return i + 4
  end

  -1
end

input = ARGV[0]
stream = File.read(input)

puts find_start_of_packet_market_index(stream)
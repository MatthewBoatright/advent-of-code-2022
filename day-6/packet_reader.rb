if ARGV.length < 1
  puts "Usage: ruby packet_reader.rb <input_file>"
  exit 1
end

def find_start_marker_index(stream, marker_length)
  chars = stream.chars

  0.upto(stream.length - marker_length) do |i|
    slice = chars.slice(i, marker_length)
    next if slice.uniq.length < marker_length

    return i + marker_length
  end

  -1
end

input = ARGV[0]
stream = File.read(input)

puts find_start_marker_index(stream, 4)
puts find_start_marker_index(stream, 14)
def process_input(input)
  res = Hash.new(0)
  cwd = []

  File.foreach(input) do |line|
    line = line.split(' ')
    case line
    in ['$', 'cd', '..']
      cwd.pop
    in ['$', 'cd' '/']
      cwd = ['/']
    in ['$', 'cd', dir]
      cwd << dir
    in ['$', 'ls']
    in ['dir', dir]
    in [size, filename]
      cwd.length.times do |i|
        res[cwd[0..i]] += size.to_i
      end
    end
  end

  res
end

if ARGV.length < 1
  puts "Usage: ruby disk_saver.rb <input_file>"
  exit 1
end

input = ARGV[0]
dir_sizes = process_input(input)

puts dir_sizes.select{ |k,v| v <= 100000 }.values.sum

filesystem_size_total = dir_sizes[["/"]]
size_needed = 30000000 - (70000000 - filesystem_size_total)

puts dir_sizes.select{ |k,v| v >= size_needed }.values.min
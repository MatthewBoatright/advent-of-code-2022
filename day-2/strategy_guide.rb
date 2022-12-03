SHAPE_MAP = {
  "A" => :rock,
  "X" => :rock,
  "B" => :paper,
  "Y" => :paper,
  "C" => :scissors,
  "Z" => :scissors,
}

SHAPE_POINTS = {
  :rock => 1,
  :paper => 2,
  :scissors => 3
}

ROUND_POINTS = {
  :lose => 0,
  :draw => 3,
  :win => 6
}

def process_input(input)
  res = []

  File.foreach(input) do |line|
    res << line.split.map { |c| SHAPE_MAP[c] }
  end

  res
end

def calculate_own_score(game)
  score = 0

  game.each do |round|
    round_result = determine_round_result(round)
    score += (SHAPE_POINTS[round.last] + ROUND_POINTS[round_result])
  end

  score
end

def determine_round_result(round)
  opponent_shape = round.first
  my_shape = round.last

  case my_shape
  when :rock
    return opponent_shape == :rock ? :draw : opponent_shape == :paper ? :lose : :win
  when :paper
    return opponent_shape == :paper ? :draw : opponent_shape == :scissors ? :lose : :win
  when :scissors
    return opponent_shape == :scissors ? :draw : opponent_shape == :rock ? :lose : :win
  end
end

if ARGV.length < 1
  puts "Usage: ruby strategy_guide.rb <input_file>"
  exit 1
end

input = ARGV[0]
game = process_input(input)
score = calculate_own_score(game)

puts score
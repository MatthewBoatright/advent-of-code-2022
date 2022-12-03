SHAPE_MAP = {
  "A" => :rock,
  "B" => :paper,
  "C" => :scissors,
}

OUTCOME_MAP = {
  "X" => :lose,
  "Y" => :draw,
  "Z" => :win
}

# shape => [shape_to_lose, shape_to_win]
RULES = {
  :rock => [:scissors, :paper],
  :paper => [:rock, :scissors],
  :scissors => [:paper, :rock],
}

SHAPE_POINTS = {
  :rock => 1,
  :paper => 2,
  :scissors => 3
}

OUTCOME_POINTS = {
  :lose => 0,
  :draw => 3,
  :win => 6
}

def process_input(input)
  res = []

  File.foreach(input) do |line|
    l = line.split
    res << [SHAPE_MAP[l.first], OUTCOME_MAP[l.last]]
  end

  res
end

def calculate_own_score(game)
  score = 0

  game.each do |round|
    opponent_shape = round.first
    outcome = round.last
    outcome_score = OUTCOME_POINTS[outcome]

    shape = determine_shape(opponent_shape, outcome)
    shape_score = SHAPE_POINTS[shape]

    score += (outcome_score + shape_score)
    puts "#{round} => Must select #{shape} for #{shape_score} points. Results in a #{outcome} for #{outcome_score} points."
  end

  score
end

def determine_shape(opponent_shape, outcome)
  return opponent_shape if outcome == :draw

  action_index = outcome == :lose ? 0 : 1
  return RULES[opponent_shape][action_index]
end

if ARGV.length < 1
  puts "Usage: ruby strategy_guide.rb <input_file>"
  exit 1
end

input = ARGV[0]
game = process_input(input)
score = calculate_own_score(game)

puts score
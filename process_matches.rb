#!/usr/bin/env ruby

require './lib/league'

# Extract [team name] [score] n times from each line
@pattern = / ?([A-z ]+) (\d+)/
@teams = []
@day = 1
@league = League.new

def print_matchday
  puts "Matchday #{@day}"
  @league.top_scores(3).each do |t,s|
    pt = s == 1 ? "pt" : "pts"
    puts "#{t}, #{s} #{pt}"
  end
  puts
end

# If ARGF is stdin: if stdin is still in tty, then
# there's no pipe, so exit; otherwise read from stdin.
# If ARGF is a filename, read from the file
# Return a stream enumerable
if ARGF.filename == '-'
  fail("No input provided") if STDIN.tty?
  stream = ARGF.each
else
  stream = IO.foreach(ARGF.filename)
end

stream.each do |line|
  # parse out teams and scores from each line
  (team1,score1), (team2,score2) = line.scan(@pattern)

  # Exit if there is a formatting issue (e.g. the regex failed)
  if [team1,score1,team2,score2].any?(&:nil?)
    fail("Input match file improperly formatted")
  end

  # Reset daily team tracker if it already contains
  # currently matched teams
  if @teams.include?(team1) || @teams.include?(team2)
    @teams = []
    print_matchday
    @day += 1
  end

  # Store match and day's contestants
  @league.match(team1, score1, team2, score2)
  @teams += [team1, team2]
end

# Print final results of last matchday
print_matchday
class League
  attr_reader :scores

  # League score tracker
  def initialize
    # Uses hash initialization to set team scores to a default 0
    @scores = Hash.new(0)
  end

  # Process and store the outcome from a match
  # Params:
  # +team1+:: First team name
  # +score1+:: First team score
  # +team2+:: Second team name
  # +score2+:: Second team score
  def match(team1, score1, team2, score2)
    s1, s2 = score(score1, score2)
    @scores[team1] += s1
    @scores[team2] += s2
  end

  # Return the top N scores from the League's current match results
  # Params:
  # +n+:: number of results to return
  def top_scores(n)
    # override n if the size is too big
    n = @scores.size if n > @scores.size
    # Sort the scoring hash descending by score and ascending by team name ;-)
    @scores.sort_by { |k,v| [-v,k] }.first(n)
  end

  private

  def score(score1, score2)
    # for simplicity, score returns results for both teams
    # defaulting to zero for teams that lost the match
    case score1 <=> score2
    when 1
      [3,0]
    when -1
      [0,3]
    else
      [1,1]
    end
  end
end

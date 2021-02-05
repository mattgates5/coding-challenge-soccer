require 'spec_helper'
require_relative '../lib/league'

teams = (1..5).map { |n| "team#{n}" }

describe "League" do
  before(:each) do
    @league = League.new
  end

  describe "#match" do
    it 'should score the first team 3 pts for a win' do
      @league.match(teams[0], 1, teams[1], 0)
      expect(@league.scores[teams[0]]).to eq 3
      expect(@league.scores[teams[1]]).to eq 0
    end

    it 'should score the second team 3 pts for a win' do
      @league.match(teams[0], 0, teams[1], 1)
      expect(@league.scores[teams[0]]).to eq 0
      expect(@league.scores[teams[1]]).to eq 3
    end

    it 'should score each team 1 pt for a tie' do
      @league.match(teams[0], 1, teams[1], 1)
      expect(@league.scores[teams[0]]).to eq 1
      expect(@league.scores[teams[1]]).to eq 1
    end
  end

  describe "#top_scores" do
    it 'should render the top 3 scores correctly' do
      scores = teams.zip [4,9,7,2,5]
      @league.instance_variable_set(:@scores, scores)
      top = @league.top_scores(3)
      expect(top.size).to eq 3
      expect(top[0]).to eq ['team2',9]
      expect(top[1]).to eq ['team3',7]
      expect(top[2]).to eq ['team5',5]
    end
  end
end


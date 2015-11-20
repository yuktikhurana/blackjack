class Player < ActiveRecord::Base
  has_many :games
  has_many :steps, through: :games

  def average_score
    games.won.average(:player_score)
  end

  def lucky_cards
    steps.for_player(true).select("card, count(*) frequency").group(:card).order("count(*) desc")
  end
end

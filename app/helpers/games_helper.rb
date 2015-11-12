module GamesHelper
  def winner_text(game)
    return "It's a tie" if game.tie?
    "#{ game.won? ? 'Player' : 'Dealer' } Wins"
  end

  def steps_for(game, player)
    game.steps.for_player(player)
  end
end

class Game < ActiveRecord::Base
  belongs_to :player
  has_many :steps
  has_one :card_stack

  validates :player, presence: true

  def start
    #give 2 cards to player, give 1 card to dealer
    initialize_stack
    give_cards(2)
    give_cards(1, false)
    analyze_scores
  end

  def over?
    !self.won.nil? || tie?
  end

  def tie?
    player_score == dealer_score
  end

  def hit
    give_cards(1)
    analyze_scores
  end

  def stand
    give_cards(1, false)
    analyze_scores(false)
  end

  private

  def initialize_stack
    build_card_stack
  end

  def give_cards(number_of_cards, player = true)
    #find a card, make a note of card found, change score of the card/dealer
    number_of_cards.times do |card|
      found_card = card_stack.find_card
      card_stack.value = card_stack.updated_value(found_card)
      steps.build(for_player: player, card: found_card)
      change_score(player, found_card)
    end
  end

  def change_score(player, card)
    card_value = CardStack.find_card_value(card)
    if player
      self.player_score += card_value
    else
      self.dealer_score += card_value
    end
  end

  def analyze_scores(player = true)
    if black_jack?(player)
      self.won = player
    elsif bust?(player)
      self.won = !player
    elsif !player
      if dealer_score <= 16
        stand
      else
        self.won = compare_scores_and_declare_winner
      end
    end
    save
  end

  def bust?(player)
    desired_player_score(player) > 21
  end

  def black_jack?(player)
    desired_player_score(player) == 21
  end

  def desired_player_score(player)
    player ? player_score : dealer_score
  end

  def compare_scores_and_declare_winner
    player_score > dealer_score
  end
end

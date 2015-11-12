class CardStack < ActiveRecord::Base
  belongs_to :game

  serialize :value, Hash

  DECK_COUNT = 6
  SPECIAL_CARDS = { a: 11, j: 10, k: 10, q: 10 }
  CARDS = (2..10).to_a + SPECIAL_CARDS.keys
  CARDS_VALUE_HASH = CARDS.inject(Hash.new { |hash, key| hash[key] = 0 }) do |cards_hash, card|
    cards_hash[card.to_s] += 1 * DECK_COUNT * 4
    cards_hash
  end

  def initialize(*args)
    super
    self.value = CARDS_VALUE_HASH
  end

  def find_card
    found = CARDS.sample
    if can_give_card?(found)
      found
    else
      find_a_card
    end
  end

  def self.find_card_value(card)
    SPECIAL_CARDS.fetch(card, card)
  end

  def updated_value(card)
    value[card.to_s] -= 1
    value
  end

  private

  def can_give_card?(card)
    debugger
    value[card.to_s] > 0
  end
end

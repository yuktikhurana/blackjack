class Step < ActiveRecord::Base
  belongs_to :game

  validates :game, :card, presence: true
  validates :card, inclusion: { in: CardStack::CARDS.map(&:to_s) } , allow_blank: true

  scope :for_player, ->(player) { where(for_player: player ) }
end

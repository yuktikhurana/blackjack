class AddBetToGames < ActiveRecord::Migration
  def change
    add_column :games, :bet, :integer, default: 1
  end
end

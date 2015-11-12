class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.belongs_to :player
      t.boolean :won
      t.integer :dealer_score, default: 0
      t.integer :player_score, default: 0

      t.timestamps null: false
    end
  end
end

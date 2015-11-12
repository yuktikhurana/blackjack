class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.belongs_to :game
      t.string :card
      t.boolean :for_player 

      t.timestamps null: false
    end
  end
end

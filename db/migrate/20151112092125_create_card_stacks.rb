class CreateCardStacks < ActiveRecord::Migration
  def change
    create_table :card_stacks do |t|
      t.belongs_to :game
      t.text :value

      t.timestamps null: false
    end
  end
end

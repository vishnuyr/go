class CreateStones < ActiveRecord::Migration
  def change
    create_table :stones do |t|
      t.integer :game_id
      t.integer :player_id
      t.boolean :is_white
      t.timestamps
    end
  end
end

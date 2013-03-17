class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :board_size
      t.integer :white_player_id
      t.integer :placing_player_id
      t.timestamps
    end
  end
end

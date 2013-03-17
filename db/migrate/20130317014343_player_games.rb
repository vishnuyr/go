class PlayerGames < ActiveRecord::Migration
  def up
    create_table :player_games do |t|
      t.integer :player_id
      t.integer :game_id
    end
    add_index :player_games, :player_id
    add_index :player_games, :game_id
  end

  def down
    drop_table :player_games
  end
end

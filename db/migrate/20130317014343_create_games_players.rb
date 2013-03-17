class CreateGamesPlayers < ActiveRecord::Migration
  def up
    create_table :games_players do |t|
      t.integer :player_id
      t.integer :game_id
    end
    add_index :games_players, :player_id
    add_index :games_players, :game_id
  end

  def down
    drop_table :games_players
  end
end

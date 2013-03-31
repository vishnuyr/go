class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :player_id
      t.integer :game_id
      t.string :content
      t.timestamps
    end
    add_index :comments, :player_id
    add_index :comments, :game_id
  end
end

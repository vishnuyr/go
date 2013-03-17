class AddPositionToStones < ActiveRecord::Migration
  def change
    add_column :stones, :x_position, :integer
    add_column :stones, :y_position, :integer
    add_index :stones, :x_position
    add_index :stones, :y_position
  end
end

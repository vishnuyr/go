class Stone < ActiveRecord::Base
  attr_accessible :x_position, :y_position

  belongs_to :player
  belongs_to :game

end

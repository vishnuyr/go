class Game < ActiveRecord::Base
  attr_accessible :board_size

  # -- Relationships --------------------------------------------------------
  has_and_belongs_to_many :players
  has_many :stones
end

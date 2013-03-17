class Game < ActiveRecord::Base
  attr_accessible :board_size

  # -- Relationships --------------------------------------------------------
  has_and_belongs_to_many :players
  has_one :placing_player
  has_many :stones

  # -- Scopes ---------------------------------------------------------------


end

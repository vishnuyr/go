class Stone < ActiveRecord::Base
  attr_accessible :x_position, :y_position, :is_white

  belongs_to :player
  belongs_to :game

  # -- Validations ----------------------------------------------------------
  validates :x_position, :y_position,
    :presence => true

  # -- Scopes ---------------------------------------------------------------
  scope :white, where(:is_white => true)
  scope :black, where(:is_white => false)

end

class Player < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :username, :email, :password, :password_confirmation

  # -- Relationships --------------------------------------------------------
  has_and_belongs_to_many :games
  has_many :stones
  has_many :comments

  # -- Callbacks ------------------------------------------------------------

  # -- Validations ----------------------------------------------------------
  validates_confirmation_of :password, :message => 'passwords did not match', :if => :password
  validates :username,
    :presence => true

end

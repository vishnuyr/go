class Player < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :username, :email, :password, :password_confirmation

  validates_confirmation_of :password, :message => 'passwords did not match', :if => :password
  validates :username,
    :presence     => true

end

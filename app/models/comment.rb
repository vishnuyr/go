class Comment < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :game
  belongs_to :player

end

class User < ActiveRecord::Base

  has_many :shares

  acts_as_authentic

end

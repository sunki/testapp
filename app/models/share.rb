class Share < ActiveRecord::Base

  validates_uniqueness_of :symbol, scope: :user_id

end

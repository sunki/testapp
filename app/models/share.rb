class Share < ActiveRecord::Base

  belongs_to :user

  validates_uniqueness_of :symbol, scope: :user_id

end

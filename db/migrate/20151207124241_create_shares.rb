class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :user_id
      t.string :symbol

      t.timestamps null: false
    end
  end
end

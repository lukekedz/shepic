class CreateStandings < ActiveRecord::Migration
  def change
    create_table :standings do |t|
      t.integer :user_id, null: false
      t.integer :wins

      t.timestamps null: false
    end
  end
end

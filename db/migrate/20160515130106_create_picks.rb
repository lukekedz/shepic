class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :user_id, null: false
      t.integer :game_id, null: false
      t.string  :pick
      t.string  :away_home
      t.integer :tbreak_pts
      t.boolean :correct

      t.timestamps null: false
    end
  end
end

class CreatePicks < ActiveRecord::Migration
  def change
    create_join_table :games, :users, table_name: :picks do |t|
      t.index   :user_id
      t.index   :game_id
      t.string  :pick
      t.integer :win
      t.integer :loss
      t.integer :tbreak_pts

      t.timestamps null: false
    end
  end
end

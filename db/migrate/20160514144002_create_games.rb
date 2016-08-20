class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.belongs_to :week,       null: false
      t.string     :date
      t.string     :away,       null: false
      t.string     :home,       null: false
      t.integer    :spread
      t.string     :location
      t.string     :start_time
      t.boolean    :tiebreaker, null: false
      t.string     :winner
      t.integer    :away_pts
      t.integer    :home_pts

      t.timestamps null: false
    end
  end
end

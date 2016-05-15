class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.belongs_to :week,       null: false
      t.string     :away,       null: false
      t.string     :home,       null: false
      t.integer    :spread,     null: false
      t.string     :location
      t.boolean    :tiebreaker, null: false

      t.timestamps null: false
    end
  end
end

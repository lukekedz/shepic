class AddDateToGames < ActiveRecord::Migration
  def change
    add_column :games, :date, :string
    change_column_null :games, :date, false
  end
end

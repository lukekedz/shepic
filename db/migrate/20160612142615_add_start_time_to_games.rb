class AddStartTimeToGames < ActiveRecord::Migration
  def change
    add_column :games, :start_time, :string
    change_column_null :games, :start_time, false
  end
end

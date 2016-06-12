class AddStartTimeToGames < ActiveRecord::Migration
  def change
    add_column :games, :start_time, :string
  end
end

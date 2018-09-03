class AddTimeRemainingToGames < ActiveRecord::Migration
  def change
    add_column :games, :time_remaining, :string
  end
end

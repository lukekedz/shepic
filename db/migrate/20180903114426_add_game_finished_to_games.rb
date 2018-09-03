class AddGameFinishedToGames < ActiveRecord::Migration
  def change
    add_column :games, :game_finished, :boolean
  end
end

class AddGameStartedToGame < ActiveRecord::Migration
    def change
        add_column :games, :game_started, :boolean, null: false
    end
end

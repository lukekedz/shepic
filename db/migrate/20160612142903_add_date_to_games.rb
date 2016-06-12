class AddDateToGames < ActiveRecord::Migration
  def change
    add_column :games, :date, :string
  end
end

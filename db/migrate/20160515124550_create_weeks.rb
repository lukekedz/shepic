class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.integer :week
      t.boolean :locked
      t.boolean :finalized

      t.timestamps null: false
    end
  end
end

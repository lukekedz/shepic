class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.integer :week, null: false
      t.boolean :locked
      t.boolean :finalized

      t.timestamps null: false
    end
  end
end

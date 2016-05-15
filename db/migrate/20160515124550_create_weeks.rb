class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.string  :week
      t.boolean :locked

      t.timestamps null: false
    end
  end
end

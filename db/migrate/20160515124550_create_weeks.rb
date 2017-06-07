class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.integer :week,      null: false
      t.boolean :locked,    default: false
      t.boolean :finalized, default: false
      
      t.timestamps null: false
    end
  end
end

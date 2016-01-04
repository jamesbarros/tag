class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :date
      t.string :price
      t.text :detail
      t.text :location
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

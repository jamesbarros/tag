class AddLatitudeAndLongitudeToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :lat, :decimal, :precision => 11, :scale => 7, :default => 0.0
    add_column :tasks, :lon, :decimal, :precision => 11, :scale => 7, :default => 0.0
  end
end

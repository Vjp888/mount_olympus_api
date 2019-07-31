class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :games
      t.string :event_name
      t.string :sport
    end
  end
end

class CreateMeals < ActiveRecord::Migration
  def up
    create_table :meals do |t|
      t.string :name
      t.integer :calories
      t.integer :user_id
      t.timestamps null: false
    end
  end

  def down
    drop_table :meals
  end
end

class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.text :about

      t.timestamps null: false
    end
    add_index :authors, [:name]
  end
end

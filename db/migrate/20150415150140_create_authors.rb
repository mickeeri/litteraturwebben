class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.integer :yearofbirth
      t.integer :yearofdeath
      t.text :about

      t.timestamps null: false
    end
  end
end

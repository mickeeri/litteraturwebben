class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.integer :yearofpub
      t.text :about
      t.string :coverurl
      t.references :genre, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

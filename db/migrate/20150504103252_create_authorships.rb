class CreateAuthorships < ActiveRecord::Migration
  def change
    create_table :authorships do |t|
      t.integer :book_id
      t.integer :author_id

      t.timestamps null: false
    end
    add_index :authorships, :book_id
    add_index :authorships, :author_id
    add_index :authorships, [:book_id, :author_id], unique: true
  end
end

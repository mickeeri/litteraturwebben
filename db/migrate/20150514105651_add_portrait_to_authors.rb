class AddPortraitToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :portrait, :string
  end
end

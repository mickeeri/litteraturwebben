class AddYearofbirthToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :yearofbirth, :integer
  end
end

class RemoveCoverurlFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :coverurl, :string
  end
end

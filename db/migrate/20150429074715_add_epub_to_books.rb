class AddEpubToBooks < ActiveRecord::Migration
  def change
    add_column :books, :epub, :string
  end
end

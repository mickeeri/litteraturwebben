class AddPdfToBooks < ActiveRecord::Migration
  def change
    add_column :books, :pdf, :string
  end
end

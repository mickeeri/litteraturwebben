class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :articles, :author, :writer
  end
end

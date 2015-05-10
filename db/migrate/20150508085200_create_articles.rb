class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.string :source
      t.string :year
      t.text :about
      t.string :url
      t.references :book, index: true, foreign_key: true
      t.references :author, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

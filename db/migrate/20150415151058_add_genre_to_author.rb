class AddGenreToAuthor < ActiveRecord::Migration
  def change
    add_reference :authors, :genre, index: true, foreign_key: true
  end
end

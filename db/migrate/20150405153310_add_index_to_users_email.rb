class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	# Adds index to email address in table users and enforces uniqueness.
  	add_index :users, :email, unique: true
  end
end

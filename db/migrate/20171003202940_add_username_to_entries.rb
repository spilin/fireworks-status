class AddUsernameToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :username, :string
  end
end

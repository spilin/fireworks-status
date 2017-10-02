class AddStateToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :state, :string
  end
end

class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.string :name
      t.string :branch

      t.timestamps
    end

    add_index :entries, :name, unique: true
  end
end

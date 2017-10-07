class AddCommitDetailsToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :commit, :string
    add_column :entries, :commit_url, :string
    add_column :entries, :subject, :string
    add_column :entries, :author, :string
  end
end

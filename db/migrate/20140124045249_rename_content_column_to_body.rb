class RenameContentColumnToBody < ActiveRecord::Migration
  def up
    rename_column :notes, :content, :body
  end
  def down
    rename_column :notes, :body, :content
  end
end

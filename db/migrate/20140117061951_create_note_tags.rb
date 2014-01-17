class CreateNoteTags < ActiveRecord::Migration
  def change
    create_table :note_tags do |t|
      t.integer :note_id
      t.integer :tag_id
      t.timestamps
    end

    add_index :note_tags, :note_id
    add_index :note_tags, :tag_id
  end
end

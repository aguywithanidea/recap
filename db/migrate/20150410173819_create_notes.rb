class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :user_id, null: false
      t.integer :member_id, null: false
      t.integer :note_tag_id, null: false
      t.string :note
      t.timestamps null: false
    end
  end
end

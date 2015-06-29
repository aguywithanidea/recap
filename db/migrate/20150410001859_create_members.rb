class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.text :email, null: false
      t.text :name
      t.timestamps null: false
    end
  end
end

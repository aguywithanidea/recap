class SeedNoteType < ActiveRecord::Migration
  def up
    Note::Tag.create(name:'action_item') rescue nil
    Note::Tag.create(name:'question') rescue nil
    Note::Tag.create(name:'concern') rescue nil
    Note::Tag.create(name:'goal') rescue nil
  end
end

class Note::Tag < ActiveRecord::Base
  has_many :notes, :foreign_key => "note_tag_id", :primary_key => "id", :class_name => "::Note"
    
  def tag
    self.name
  end
end

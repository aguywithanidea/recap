class Note < ActiveRecord::Base

  belongs_to :tag, :class_name=>'Note::Tag', :foreign_key => "note_tag_id"
  
  # delegate :tag to: :note_tag
  
  belongs_to :user
  
  belongs_to :member
  # delegate :name to: :member

end

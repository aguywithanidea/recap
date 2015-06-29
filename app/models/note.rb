class Note < ActiveRecord::Base
  HUMANIZED_ATTRIBUTES = {
    :note_tag_id => "Type"
  }
  scope :today_by_user, ->(uid) { where("created_at::date = current_date and user_id = ?", uid) }
  scope :reverse, -> { order(id:'desc') } 
  belongs_to :tag, :class_name=>'Note::Tag', :foreign_key => "note_tag_id"
  validates_presence_of :member_id, :note_tag_id, :note
  
  # delegate :tag to: :note_tag
  
  belongs_to :user
  
  belongs_to :member
  # delegate :name to: :member

  # Give us human attribute name instead of column name
  def self.human_attribute_name(attr,options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

end

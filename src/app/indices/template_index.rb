ThinkingSphinx::Index.define :template, :with => :active_record do
  # Fields
  indexes title, :sortable => true
  indexes description
  
  # Attributes
  has created_at, updated_at
end
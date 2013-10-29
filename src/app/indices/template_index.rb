ThinkingSphinx::Index.define :template, :with => :active_record do
  # Fields
  indexes title, :sortable => true
  indexes description
  indexes price
  #indexes category.name, :as => :category, :sortable => true
  
  # Attributes
  has created_at, updated_at
end
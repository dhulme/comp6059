class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :creator
      t.text :comment
      t.integer :rating, max: 5, min: 0
      
      t.belongs_to :template
      
      t.timestamps
    end
  end
end

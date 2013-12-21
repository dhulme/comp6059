class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :rating, max: 5, min: 0
      
      t.belongs_to :template
      t.belongs_to :user
      
      t.timestamps
    end
  end
end

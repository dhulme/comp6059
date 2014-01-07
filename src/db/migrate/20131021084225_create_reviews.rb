class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :rating, max: 5, min: 0, :null => false
      
      t.belongs_to :template, :null => false
      t.belongs_to :user, :null => false
      
      t.timestamps
    end
  end
end

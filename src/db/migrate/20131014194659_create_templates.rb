class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :title, :null => false
      t.text :description, :null => false
      t.string :filename, :null => false
      
      t.references :category, :null => false
      t.belongs_to :user, :null => false

      t.timestamps
    end
  end
end
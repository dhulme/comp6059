class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.references :creator
      t.string :title
      t.text :description
      t.decimal :price
      t.integer :downloads, default: 0
      t.string :filename
      
      t.belongs_to :category

      t.timestamps
    end
  end
end
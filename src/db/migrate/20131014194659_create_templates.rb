class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.references :creator
      t.string :title
      t.text :description
      t.decimal :price
      t.integer :downloads
      t.string :filename

      t.timestamps
    end
  end
end
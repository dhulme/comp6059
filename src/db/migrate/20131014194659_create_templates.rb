class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.references :creator
      t.string :name
      t.text :description
      t.decimanl :price
      t.integer :downloads
      t.binary :image

      t.timestamps
    end
  end
end

class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :title
      t.text :description
      t.string :filename
      
      t.references :category
      t.belongs_to :user

      t.timestamps
    end
  end
end
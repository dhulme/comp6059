class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.references :user, :null => false
      t.references :template, :null => false
      
      t.timestamps
    end
  end
end

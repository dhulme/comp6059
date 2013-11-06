class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.references :user
      t.references :template
      
      t.timestamps
    end
  end
end

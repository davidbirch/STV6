class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :nickname
      t.string :image
      t.string :email
      t.text :source
      t.boolean :admin
      
      t.timestamps null: false
      
    end
  end
end

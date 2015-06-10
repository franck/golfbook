class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :email
      t.string :firstname
      t.string :lastname

      t.timestamps null: false
    end
  end
end

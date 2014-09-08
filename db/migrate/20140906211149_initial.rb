class Initial < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :external_id, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.timestamps
    end
    add_index :users, [:external_id], unique: true

    create_table :organization_memberships do |t|
      t.integer :user_id, null: false
      t.integer :organization_id, null: false
      t.timestamps
    end
    add_index :organization_memberships, [:user_id, :organization_id], unique: true

    create_table :organizations do |t|
      t.string :name, null: false
      t.string :github_token
      t.text :repositories
      t.timestamps
    end
    add_index :organizations, [:name], unique: true
  end
end

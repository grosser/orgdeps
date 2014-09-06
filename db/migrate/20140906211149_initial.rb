class Initial < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :external_id, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.timestamps
    end
    add_index :users, [:external_id], unique: true

    create_table :organization_memberships do |t|
      t.integer :user_id, null: false
      t.integer :organization_id, null: false
    end
    add_index :organization_memberships, [:user_id, :organization_id], unique: true

    create_table :organizations do |t|
      t.string :name, null: false
      t.string :github_token, null: false
      t.text :repositories
    end
    add_index :organizations, [:name], unique: true
  end
end

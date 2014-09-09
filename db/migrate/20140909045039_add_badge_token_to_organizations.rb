class AddBadgeTokenToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :badge_token, :string
    Organization.reset_column_information
    Organization.find_each do |org|
      org.send(:generate_badge_token)
      org.update_column(:badge_token, org.badge_token)
    end
    change_column :organizations, :badge_token, :string, null: false
  end
end

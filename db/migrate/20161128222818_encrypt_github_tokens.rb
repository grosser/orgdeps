class EncryptGithubTokens < ActiveRecord::Migration
  class Organization < ActiveRecord::Base
  end

  def up
    rename_column :organizations, :github_token, :github_token_old
    add_column :organizations, :encrypted_github_token, :string
    add_column :organizations, :encrypted_github_token_iv, :string

    mark_column_as_encrypted

    Organization.find_each do |org|
      org.github_token = org.github_token_old
      org.save!
    end

    remove_column :organizations, :github_token_old, :string
  end

  def down
    add_column :organizations, :github_token_old, :string

    mark_column_as_encrypted

    Organization.find_each do |org|
      org.github_token_old = org.github_token
      org.save!
    end

    rename_column :organizations, :github_token_old, :github_token
    remove_column :organizations, :encrypted_github_token
    remove_column :organizations, :encrypted_github_token_iv
  end

  # Will inspect the current db state, so needs to be done just in time
  def mark_column_as_encrypted
    Organization.send :attr_encrypted, :github_token, key: Rails.application.secrets.secret_key_base, algorithm: 'aes-256-cbc'
  end
end

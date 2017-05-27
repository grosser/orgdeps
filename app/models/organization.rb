class Organization < ActiveRecord::Base
  SAFE_TOKEN_SIZE = 7
  MAX_VERSIONS = 4

  before_create :generate_badge_token

  serialize :repositories

  attribute :github_token # TODO: bump attr_encrypted to remove this
  attr_encrypted :github_token, key: Rails.application.secrets.secret_key_base, algorithm: 'aes-256-cbc'

  # A hack to make attr_encrypted always behave the same even when loaded without a database being present.
  # On load it checks if the column exists and then defined attr_accessors if they do not.
  # Reproduce with:
  # CI=1 RAILS_ENV=test TEST=test/lib/samson/secrets/db_backend_test.rb rake db:drop db:create default
  #
  # https://github.com/attr-encrypted/attr_encrypted/issues/226
  column = :github_token
  bad = [
    :"encrypted_#{column}_iv",
    :"encrypted_#{column}_iv=",
    :"encrypted_#{column}",
    :"encrypted_#{column}="
  ]
  (instance_methods & bad).each { |m| undef_method m }

  def to_s
    name
  end

  def safe_github_token
    github_token.to_s[0...SAFE_TOKEN_SIZE]
  end

  def safe_github_token=(token)
    self.github_token = token if token.size != SAFE_TOKEN_SIZE
  end

  def update_repositories
    data = RepoDependencyGraph.dependencies(
      token: github_token,
      organization: name,
      private: true,
    )
    update_attributes!(
      repositories: data,
      repositories_updated_at: Time.now
    )
  end

  def to_param
    name
  end

  def self.find_by_param!(param)
    where(name: param).first!
  end

  def repository_names
    (repositories.keys | repositories.flat_map { |n,d| d.map(&:first) }).sort
  end

  def repository(name)
    return unless repository_names.include?(name)
    uses = (repositories[name] || [])
    used = repositories.map do |d, uses|
      used = uses.detect { |d| d.first == name }
      [d, used[1]] if used
    end.compact
    [uses, used]
  end

  def badge_url(repository)
    uses, used = repository(repository)
    text, color = if uses
      versions = used.map {|_name, version| version }.compact.uniq.sort
      versions = versions.presence || ['None']
      if versions.size > MAX_VERSIONS
        versions = versions[0...MAX_VERSIONS] + ['...']
      end
      [versions.join(' / '), (versions.size == 1 ? 'green' : 'yellow')]
    else
      ['404', 'red']
    end
    "https://img.shields.io/badge/OrgDeps-#{CGI.escape(text).gsub('+', '%20')}-#{color}.svg"
  end

  private

  def generate_badge_token
    self.badge_token = SecureRandom.hex(16)
  end
end

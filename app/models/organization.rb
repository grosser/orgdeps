class Organization < ActiveRecord::Base
  SAFE_TOKEN_SIZE = 7
  MAX_VERSIONS = 4

  before_create :generate_badge_token

  serialize :repositories

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

  def repository(name)
    uses = repositories[name]
    used = repositories.map do |d, uses|
      used = uses.detect { |d| d.first == name }
      [d, used[1]] if used
    end.compact
    [uses, used]
  end

  def badge(repository)
    versions = repository(repository).last.map {|name, version| version }.compact.uniq.sort
    versions = versions.presence || ['None']
    if versions.size > MAX_VERSIONS
      versions = versions[0...MAX_VERSIONS] + ["..."]
    end
    color = (versions.size == 1 ? 'green' : 'yellow')
    open("http://img.shields.io/badge/OrgDeps-#{CGI.escape(versions.join(' / ')).gsub('+', '%20')}-#{color}.svg").read
  end

  private

  def generate_badge_token
    self.badge_token = SecureRandom.hex(16)
  end
end

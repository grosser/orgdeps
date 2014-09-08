class Organization < ActiveRecord::Base
  SAFE_TOKEN_SIZE = 7

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
end

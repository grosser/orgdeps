class Organization < ActiveRecord::Base
  serialize :repositories

  def to_s
    name
  end

  def safe_github_token
    github_token.to_s[0...7]
  end

  def safe_github_token=(token)
    self.github_token = token
  end
end

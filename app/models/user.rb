class User < ActiveRecord::Base
  has_many :organization_memberships
  has_many :organizations, through: :organization_memberships

  class << self
    def authenticate(auth)
      external_id = "#{auth.fetch("provider")}-#{auth.fetch("uid")}"
      where(:external_id => external_id).first || begin
        raise "Unknown orgs" unless organizations = github_organizations(auth).presence
        User.create!(
          name: auth["info"]["name"] || auth["info"]["nickname"] || "No name",
          email: auth["info"]["email"],
          external_id: external_id,
          organizations: organizations
        )
      end
    end

    private

    def github_organizations(auth)
      url = "https://api.github.com/user/orgs?access_token=#{auth.fetch("credentials").fetch("token")}"
      response = HTTParty.get(url, headers: {"User-Agent" => "orgdeps"})
      response.map{|x| Organization.find_by_name(x.fetch("login")) }.compact
    end
  end
end

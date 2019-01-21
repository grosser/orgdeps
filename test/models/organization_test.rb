require './test/test_helper'

describe Organization do
  let(:organization) { organizations(:minimum) }

  describe "#safe_token" do
    it "is short" do
      organization.safe_github_token.must_equal "thetoke"
    end

    it "is empty for nil" do
      Organization.new.safe_github_token.must_equal ""
    end
  end

  describe "#safe_token=" do
    it "can set" do
      organization.safe_github_token = "12345678912345678123456"
      organization.github_token.must_equal "12345678912345678123456"
    end

    it "ignores update with unchanged form value" do
      organization.safe_github_token = "1234567"
      organization.github_token.must_equal "thetokencanbeverylongindeed"
    end
  end

  describe "#update_repositories" do
    it "updates" do
      RepoDependencyGraph.expects(:dependencies).returns "x" => "y"
      organization.update_repositories
      organization.repositories.must_equal "x" => "y"
      organization.repositories_updated_at.wont_be_nil
    end
  end

  describe "#generate_badge_token" do
    it "generates" do
      Organization.create!(name: 'xxx').badge_token.wont_be_nil
    end
  end

  describe "#badge" do
    it "generates" do
      organization.badge_url("b").must_equal "https://img.shields.io/badge/OrgDeps-master%20%2F%20~%3E%200.1-yellow.svg"
    end

    it "generates for empty" do
      organization.badge_url("a").must_equal "https://img.shields.io/badge/OrgDeps-None-green.svg"
    end

    it "generates 404 for unknown" do
      organization.badge_url("x").must_equal "https://img.shields.io/badge/OrgDeps-404-red.svg"
    end
  end

  describe "#badge_parts" do
    it "sorts branches to the front" do
      sorted, _ = organization.send(:badge_parts, ["2.3.0", "1.2.0", "1.10.2", "1.10.10", "master", "fire"], true)
      sorted.must_equal "fire / master / 1.2.0 / ..."
    end

    it "sorts numbers naturally" do
      sorted, _ = organization.send(:badge_parts, ["2.3.0", "1.2.0", "1.10.2", "1.10.10"], true)
      sorted.must_equal "1.2.0 / 1.10.2 / 1.10.10 / 2.3.0"
    end
  end

  describe "#repository_names" do
    it "lists all repos" do
      organization.repository_names.must_equal ['a', 'b', 'c']
    end
  end

  describe "#repository" do
    it "shows uses and used" do
      organization.repository('a').must_equal [
        [["b", "~> 0.1"], ["c"]],
        []
      ]

      organization.repository('c').must_equal [
        [["b", "master"]],
        [["a", nil]]
      ]
    end
  end
end

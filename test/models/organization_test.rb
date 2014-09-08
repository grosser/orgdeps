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
end

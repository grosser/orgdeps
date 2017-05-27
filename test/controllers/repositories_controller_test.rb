require './test/test_helper'

describe RepositoriesController do
  let(:organization) { organizations(:minimum) }

  describe "#index" do
    it "renders" do
      login_as users(:minimum)
      get "/organizations/#{organization.to_param}/repositories"
      assert_response :success
      response.body.must_include "<!DOCTYPE html"
    end

    it "renders json" do
      login_as users(:minimum)
      get "/organizations/#{organization.to_param}/repositories.json"
      assert_response :success
      JSON.parse(response.body).must_equal("a"=>[["b", "~> 0.1"], ["c"]], "c"=>[["b", "master"]])
    end

    it "does not render if I do not have access" do
      login_as User.create!(name: "xxx", email: "foo@bar.com", external_id: "12345")
      get "/organizations/#{organization.to_param}/repositories"
    end
  end

  describe "#show" do
    before do
      stub_request(:get, "https://img.shields.io/badge/OrgDeps-master%20%2F%20~%3E%200.1-yellow.svg")
    end

    it "renders badge" do
      get "/organizations/#{organization.to_param}/repositories/b.svg", params: {token: organization.badge_token}
      assert_response :redirect
    end

    it "does not render with invalid token" do
      get "/organizations/#{organization.to_param}/repositories/b.svg", params: {token: "blob"}
      assert_response :not_found
    end
  end
end

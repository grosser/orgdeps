require './test/test_helper'

describe RepositoriesController do
  let(:organization) { organizations(:minimum) }

  describe "#index" do
    it "renders" do
      login_as users(:minimum)
      get :index, organization_id: organization
      assert_response :success
    end

    it "does not render if I do not have access" do
      login_as User.create!(name: "xxx", email: "foo@bar.com", external_id: "12345")
      get :index, organization_id: organization
    end
  end

  describe "#show" do
    before do
      stub_request(:get, "https://img.shields.io/badge/OrgDeps-master%20%2F%20~%3E%200.1-yellow.svg")
    end

    it "renders badge" do
      get :show, id: "b", organization_id: organization, token: organization.badge_token, format: :svg
      assert_response :success
    end

    it "does not render with invalid token" do
      get :show, id: "b", organization_id: organization, token: "blob", format: :svg
      assert_response :not_found
    end
  end
end

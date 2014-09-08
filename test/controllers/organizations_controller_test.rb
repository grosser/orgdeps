require './test/test_helper'

describe OrganizationsController do
  let(:organization) { organizations(:minimum) }

  before { login_as users(:minimum) }

  describe "#index" do
    it "renders" do
      get :index
      assert_response :success
    end
  end

  describe "#edit" do
    it "renders" do
      get :edit, id: organization.id
      assert_response :success
      assert assigns[:organization]
    end

    it "is not found for user that does not belong" do
      organization = Organization.create!(name: "other")
      get :edit, id: organization.id
      assert_response :not_found
    end

    it "does not show full token" do
      get :edit, id: organization.id
      refute_includes response.body, organization.github_token
    end
  end

  describe "#update" do
    it "updates token" do
      put :update, id: organization.id, organization: {safe_github_token: "123456781234567"}
      assert_redirected_to "/organizations/#{organization.id}/repositories"
      organization.reload.github_token.must_equal "123456781234567"
    end

    it "does not update anything else" do
      put :update, id: organization.id, organization: {name: "123456781234567"}
      organization.reload.name.must_equal "minimum"
    end
  end
end

require './test/test_helper'

describe RepositoriesController do
  let(:organization) { organizations(:minimum) }

  before { login_as users(:minimum) }

  describe "#index" do
    it "renders" do
      get :index, organization_id: organization
      assert_response :success
    end

    it "does not render if I do not have access" do
      login_as User.create!(name: "xxx", email: "foo@bar.com", external_id: "12345")
      get :index, organization_id: organization
      assert_response :not_found
    end
  end
end

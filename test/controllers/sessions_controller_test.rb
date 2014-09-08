require './test/test_helper'

describe SessionsController do
  describe "#create" do
    it "creates a user" do
      stub_request(:get, "https://api.github.com/user/orgs?access_token=thetoken").to_return(
        status: 200,
        body: JSON.dump([{"login" => "minimum"}]),
        headers: { 'Content-Type' => 'application/json' }
      )

      request.env["omniauth.auth"] = {
        "provider" => "github",
        "uid" => "abc",
        "info" => {
          "name" => "A Name",
          "email" => "email@foo.com"
        },
        "credentials" => {
          "token" => "thetoken"
        }
      }

      post :create, provider: "github"

      assert_redirected_to "/"
      user = User.find(session[:user_id])
      user.name.must_equal "A Name"
      user.email.must_equal "email@foo.com"
      user.external_id.must_equal "github-abc"
      user.organizations.map(&:name).must_equal ["minimum"]
    end

    describe "with existing user" do
      before do
        provider, uid = users(:minimum).external_id.split("-")
        request.env["omniauth.auth"] = {
          "provider" => provider,
          "uid" => uid
        }
      end

      it "logs in an existing user" do
        post :create, provider: "github"
        assert_redirected_to "/"
        session[:user_id].must_equal users(:minimum).id
      end

      it "returns to wanted location" do
        session[:return_to] = "/foobar"
        post :create, provider: "github"
        assert_redirected_to "/foobar"
      end
    end
  end

  describe "#destroy" do
    it "logs the user out" do
      login_as users(:minimum)
      delete :destroy
      refute session[:user_id]
      assert_response :success # cannot redirect since every action will log you in again
    end
  end
end

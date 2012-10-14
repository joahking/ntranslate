require 'spec_helper'

describe SessionsController do
  before do
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      :uid      => '123456',
      :info => OmniAuth::AuthHash::InfoHash.new({
        :name  => "Johny Translator",
        :email => "john.translator@example.net",
        :image => "http://john.translator.avatar.com"
      })
    # etc.
    })
    request.env["omniauth.auth"]  = OmniAuth.config.mock_auth[:github]
  end

  it "should authenticate github users" do
    visit root_path
    click_link "Sign in with Github"
    page.should have_content("Signed in!")

    user = User.last
    user.name.should   eq("Johny Translator")
    user.email.should  eq("john.translator@example.net")
    user.avatar.should eq("http://john.translator.avatar.com")

    ident = user.identities.first
    ident.provider.should eq("github")
    ident.uid.should      eq("123456")
  end
end

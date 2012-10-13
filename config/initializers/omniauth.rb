Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, "3e88fde4b68e8913f971", "f6ea0b1d85e809b3040600a76994579ded658977"
end

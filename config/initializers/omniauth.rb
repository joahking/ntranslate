Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  if Rails.env.development?
    # Hack to avoid getting those nasty ssl errors
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
    provider :github, "6dd7d5711e4f037fed19", "2c0593c9142a67a692e6f3b828a8715aa1df0edd"
  else
    provider :github, "3e88fde4b68e8913f971", "f6ea0b1d85e809b3040600a76994579ded658977"
  end

  provider :twitter, "69WRokStHkAYXFAkJLBg", "GxODj593Aw1JMotPZZOuooBjJUeknfPSH33QmS9xYU"
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'vYD9vFWKD1y61KmyOHMQ', '6rrlVXv8Etm6D7laq3WXEHWQkFyq7FqNumdijOpvLg'
  provider :facebook, '250106065102084', 'bf7d1c11ea6f2a7bb33c45bb5bc9023e'
  provider :linkedin,  '23tnucstgehl', 'ES51JYuO8erFpMmn'
  provider :google, '525550140585.apps.googleusercontent.com', 'CaoxzJ3UmC3bONanMRZgmoSl'
end
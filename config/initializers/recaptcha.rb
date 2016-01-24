# config/initializers/recaptcha.rb
# reCAPTCHA gem configure file
# ENV are set in console via source file or heroku config:set ENV_NAME
Recaptcha.configure do |config|
  config.public_key  = ENV['RECAPTCHA_PUBLIC_KEY']
  config.private_key = ENV['RECAPTCHA_PRIVATE_KEY']
  config.api_version = 'v2'
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
  #
end

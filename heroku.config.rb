# Default settings required for Heroku deployment

module CuttingEdge
  SERVER_HOST = "#{ENV['HEROKU_APP_NAME']}.herokuapp.com" # At what domain is this CuttingEdge instance running?
  SERVER_URL = "https://#{SERVER_HOST}"
  MAIL_TO = ENV['CUTTING_EDGE_MAIL_TO'] if ENV['CUTTING_EDGE_MAIL_TO']
  
  # Your additional configuration goes here.
  # If you are going to host the repository containing this file publically (e.g. on GitHub), please read:
  # https://github.com/repotag/cutting_edge/blob/master/README.md#Defining-repositories-in-configrb
  
  SECRET_TOKEN = ENV['CUTTING_EDGE_TOKEN']
  require './lib/cutting_edge/repo.rb'
  REPOSITORIES = {
    "gitlab/#{ENV['PRIVATE_REPO1_ORG']}/#{ENV['PRIVATE_REPO1_NAME']}" => GitlabRepository.new(org: ENV['PRIVATE_REPO1_ORG'], name: ENV['PRIVATE_REPO1_NAME'], lang: 'python', auth_token: ENV['PRIVATE_REPO1_TOKEN'], hide: ENV['SECRET_REPO1_HIDE_TOKEN'])#, email: ENV['PRIVATE_REPO1_MAIL'])
  }
end

::SemanticLogger.add_appender(io: $stderr)

# Configure mail server settings
require 'mail'
Mail.defaults do
  delivery_method :smtp, address: ENV['MAILGUN_SMTP_SERVER'], port: ENV['MAILGUN_SMTP_PORT'], user_name: ENV['MAILGUN_SMTP_LOGIN'], password: ENV['MAILGUN_SMTP_PASSWORD'], domain: CuttingEdge::SERVER_HOST
end
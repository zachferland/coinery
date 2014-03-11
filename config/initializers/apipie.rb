Apipie.configure do |config|
  config.app_name                = "Coinery"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/api/doc"
  # were is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/*.rb"
  config.app_info = "Below is the documentation for each type of API call you can make to Coinery"
end

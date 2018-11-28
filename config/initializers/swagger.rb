class Swagger::Docs::Config
  def self.transform_path path, api_version
    "apidocs/#{path}"
  end
end

Swagger::Docs::Config.base_api_controller = ActionController::API

Swagger::Docs::Config.register_apis(
  {
    "1.0" =>  {
      api_extension_type: :json,
      api_file_path: "public/apidocs",
      base_path: ENV["base_path"],
      clean_directory: true,
      attributes: {
        info: {
          "title" => "Document api for project training edulearning",
          "description" => "API for project training edulearning",
          "termsOfServiceUrl" => "",
          "contact" => ""
        }
      }
    }
  }
)

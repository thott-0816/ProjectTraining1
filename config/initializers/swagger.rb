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
      base_path: "http://localhost:3000",
      clean_directory: true,
      attributes: {
        info: {
          "title" => "Application ahihi",
          "description" => "Rails API documention with Swagger UI.",
          "termsOfServiceUrl" => "",
          "contact" => ""
        }
      }
    }
  }
)

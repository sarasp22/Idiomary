RubyLLM.configure do |config|
  config.gemini_api_key = ENV["GEMINI_API_KEY"].presence || Rails.application.credentials.dig(:gemini, :api_key)
end

RubyLLM.configure do |config|
  config.gemini_api_key = Rails.application.credentials.dig(:gemini, :api_key)
end

chat = RubyLLM.chat(model: "gemini-2.5-flash")

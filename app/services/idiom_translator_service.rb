require 'httparty'

class IdiomTranslatorService
  include HTTParty
  base_uri 'https://generativelanguage.googleapis.com'

  def initialize
    @api_key = Rails.application.credentials.gemini[:api_key]
  end

  def translate_idiom(idiom, source_lang, target_lang)
    prompt = build_prompt(idiom, source_lang, target_lang)

    response = self.class.post(
      "/v1/models/gemini-2.5-flash:generateContent",
      query: { key: @api_key },
      headers: { 'Content-Type' => 'application/json' },
      body: {
        contents: [{
          parts: [{
            text: prompt
          }]
        }]
      }.to_json
    )

    if response.success?
      response.dig('candidates', 0, 'content', 'parts', 0, 'text')
    else
      "Error: #{response.code} - #{response.message}"
    end
  end

  private

  def build_prompt(idiom, source_lang, target_lang)
    lang_names = { 'it' => 'Italian', 'en' => 'English', 'fr' => 'French' }

    <<~PROMPT
      You are an expert in idioms and translations.

      Idiom: "#{idiom}"
      Source language: #{lang_names[source_lang]}
      Target language: #{lang_names[target_lang]}

      Please provide:
      1. The meaning of this idiom in #{lang_names[target_lang]}
      2. An example of how it's used in context
      3. Any equivalent idioms in #{lang_names[target_lang]}

      Respond in #{lang_names[target_lang]} in a clear and concise way.
    PROMPT
  end
end

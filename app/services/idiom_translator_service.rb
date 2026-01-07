require 'httparty'

class IdiomTranslatorService
  include HTTParty
  base_uri 'https://generativelanguage.googleapis.com'

  def initialize
    @api_key = Rails.application.credentials.gemini[:api_key]
  end

  def translate_idiom(idiom, source_lang, target_lang, interface_lang = 'en')
    prompt = build_prompt(idiom, source_lang, target_lang, interface_lang)

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
      }.to_json,
      timeout: 30
    )

    case response.code
    when 200
      response.dig('candidates', 0, 'content', 'parts', 0, 'text')
    when 503
      "The translation service is temporarily unavailable. Please try again in a few moments."
    when 429
      "Too many requests. Please wait a moment and try again."
    when 400
      "Invalid request. Please check your input."
    else
      "Error #{response.code}: Unable to translate at this time. Please try again later."
    end
  rescue StandardError => e
    Rails.logger.error "Translation error: #{e.message}"
    "An error occurred while translating. Please try again."
  end

  private

  def build_prompt(idiom, source_lang, target_lang, interface_lang)
    lang_names = {
      'it' => 'Italian',
      'en' => 'English',
      'fr' => 'French',
      'es' => 'Spanish',
      'pt' => 'Portuguese'
    }

    <<~PROMPT
      Idiom: "#{idiom}" (#{lang_names[source_lang]} → #{lang_names[target_lang]})

      Respond in #{lang_names[interface_lang]} with this format:
      • Literal: [translation in #{lang_names[target_lang]}]
      • Equivalent: [idiom in #{lang_names[target_lang]} or "none"]
      • Meaning: [brief explanation]
      • Example: [one short sentence in #{lang_names[target_lang]}]

      Be concise.
    PROMPT
  end
end

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

    labels = get_labels(interface_lang)

    <<~PROMPT
      Idiom: "#{idiom}" (#{lang_names[source_lang]} → #{lang_names[target_lang]})

      Respond ONLY in #{lang_names[interface_lang]} using this EXACT format:

      #{labels[:literal]}: [literal translation of the idiom in #{lang_names[target_lang]}]
      #{labels[:equivalent]}: [equivalent idiom in #{lang_names[target_lang]}, or write "#{labels[:none]}"]
      #{labels[:meaning]}: [brief explanation of what the idiom means]
      #{labels[:example]}: [one short example sentence in #{lang_names[target_lang]}]

      IMPORTANT:
      - Use the labels exactly as shown above (#{labels[:literal]}, #{labels[:equivalent]}, #{labels[:meaning]}, #{labels[:example]})
      - The literal translation and equivalent must be in #{lang_names[target_lang]}
      - The explanation and all other text must be in #{lang_names[interface_lang]}
      - Keep it concise
    PROMPT
  end

  def get_labels(lang)
    labels_map = {
      'en' => { literal: 'Literal', equivalent: 'Equivalent', meaning: 'Meaning', example: 'Example', none: 'none' },
      'it' => { literal: 'Letterale', equivalent: 'Equivalente', meaning: 'Significato', example: 'Esempio', none: 'nessuno' },
      'fr' => { literal: 'Littéral', equivalent: 'Équivalent', meaning: 'Signification', example: 'Exemple', none: 'aucun' },
      'es' => { literal: 'Literal', equivalent: 'Equivalente', meaning: 'Significado', example: 'Ejemplo', none: 'ninguno' },
      'pt' => { literal: 'Literal', equivalent: 'Equivalente', meaning: 'Significado', example: 'Exemplo', none: 'nenhum' }
    }

    labels_map[lang] || labels_map['en']
  end
end

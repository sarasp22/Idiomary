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
      format_response(response.dig('candidates', 0, 'content', 'parts', 0, 'text'))
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
      You are an expert in idioms and translations.

      Idiom: "#{idiom}" (#{lang_names[source_lang]} → #{lang_names[target_lang]})
      Interface language: #{lang_names[interface_lang]}

      Provide a translation using this EXACT format:

      **#{labels[:literal]}**: [literal translation of "#{idiom}" in #{lang_names[target_lang]}]

      **#{labels[:equivalent]}**: [equivalent idiom in #{lang_names[target_lang]}, or write "#{labels[:none]}" if there isn't one]

      **#{labels[:meaning]}**: [brief explanation in #{lang_names[interface_lang]} of what this idiom means]

      **#{labels[:example_target]}**: [one example sentence showing how to use the idiom in #{lang_names[target_lang]}]

      **#{labels[:example_source]}**: [one example sentence showing how it's used in the original language #{lang_names[source_lang]}]

      IMPORTANT RULES:
      - Use ** for bold labels exactly as shown above
      - The literal translation and equivalent MUST be in #{lang_names[target_lang]}
      - The meaning explanation MUST be in #{lang_names[interface_lang]}
      - First example MUST be in #{lang_names[target_lang]}
      - Second example MUST be in #{lang_names[source_lang]} (the original language of the idiom)
      - Keep all responses concise and clear
      - Do NOT add extra formatting or explanations
    PROMPT
  end

  def get_labels(lang)
    labels_map = {
      'en' => {
        literal: 'Literal',
        equivalent: 'Equivalent',
        meaning: 'Meaning',
        example_target: 'Example',
        example_source: 'Example (original language)',
        none: 'none'
      },
      'it' => {
        literal: 'Letterale',
        equivalent: 'Equivalente',
        meaning: 'Significato',
        example_target: 'Esempio',
        example_source: 'Esempio (lingua originale)',
        none: 'nessuno'
      },
      'fr' => {
        literal: 'Littéral',
        equivalent: 'Équivalent',
        meaning: 'Signification',
        example_target: 'Exemple',
        example_source: 'Exemple (langue original)',
        none: 'aucun'
      },
      'es' => {
        literal: 'Literal',
        equivalent: 'Equivalente',
        meaning: 'Significado',
        example_target: 'Ejemplo',
        example_source: 'Ejemplo (en lengua original)',
        none: 'ninguno'
      },
      'pt' => {
        literal: 'Literal',
        equivalent: 'Equivalente',
        meaning: 'Significado',
        example_target: 'Exemplo',
        example_source: 'Exemplo (original)',
        none: 'nenhum'
      }
    }

    labels_map[lang] || labels_map['en']
  end

  def format_response(text)
    return text unless text

    text.gsub(/\*\*(.*?)\*\*/, '<strong>\1</strong>')
  end
end

class TranslationsController < ApplicationController
  before_action :authenticate_user!, only: [:save, :my_dictionary, :destroy]

  def search
    if params[:idiom].present?
      @idiom = params[:idiom]
      @source_lang = params[:source_lang]
      @target_lang = params[:target_lang]
      @interface_lang = I18n.locale.to_s

      service = IdiomTranslatorService.new
      @result = service.translate_idiom(@idiom, @source_lang, @target_lang, @interface_lang)
    end
  end

  def save
    @translation = current_user.saved_translations.create(
      original_idiom: params[:original_idiom],
      source_language: params[:source_language],
      target_language: params[:target_language],
      ai_response: params[:ai_response]
    )

    redirect_to my_dictionary_path, notice: t('notices.saved')
  end

  def my_dictionary
    @saved_translations = current_user.saved_translations.order(created_at: :desc)
  end

  def destroy
    @translation = current_user.saved_translations.find(params[:id])
    @translation.destroy
    redirect_to my_dictionary_path, notice: t('notices.removed')
  end
end

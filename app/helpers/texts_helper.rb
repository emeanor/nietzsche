module TextsHelper

  def kgw_numbers_string(text)
    I18n.t('texts.kgw_numbers_long', notebook_number: text.kgw_notebook_number, text_number: text.kgw_text_number)
  end

end
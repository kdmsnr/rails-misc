# -*- coding: utf-8 -*-
require 'active_model/validations'
require 'active_support/i18n'

ActiveModel::Validations::HelperMethods.module_eval do
  def validates_email_of(*attr_names)
    attr_names << {with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/}
    validates_format_of *attr_names
  end

  def validates_zenkaku_of(*attr_names)
    attr_names << {with:  /\A[^ -~｡-ﾟ]*\z/,
                   message: I18n.t("errors.messages.not_a_zenkaku") }
    validates_format_of *attr_names
  end

  def validates_hiragana_of(*attr_names)
    attr_names << {with: /\A\p{hiragana}*\z/,
                   message: I18n.t("errors.messages.not_a_hiragana") }
    validates_format_of *attr_names
  end

  def validates_katakana_of(*attr_names)
    attr_names << {with: /\A\p{katakana}*\z/,
                   message: I18n.t("errors.messages.not_a_katakana") }
    validates_format_of *attr_names
  end
end

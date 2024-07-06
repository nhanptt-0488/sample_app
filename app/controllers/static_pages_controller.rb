class StaticPagesController < ApplicationController
  def home; end

  def help; end

  before_action :set_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end

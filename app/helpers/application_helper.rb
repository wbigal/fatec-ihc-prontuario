module ApplicationHelper
  delegate :pessoa_signed_in?, to: :controller
  delegate :current_pessoa, to: :controller

  def medico_signed_in?
    pessoa_signed_in? && current_pessoa.medico.present?
  end
end

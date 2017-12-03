module ApplicationHelper
  delegate :pessoa_signed_in?, to: :controller
  delegate :current_pessoa, to: :controller
end

RSpec.configure do |config|
  config.before(:each, :authenticated) do
    controller.current_pessoa = current_pessoa
  end

  config.before(:each, :authenticated_doctor) do
    controller.current_pessoa = current_pessoa_medico.pessoa
  end

  def current_pessoa
    @current_pessoa ||= create(:pessoa, :with_account)
  end

  def current_pessoa_medico
    @current_pessoa_medico ||= create(:medico)
  end
end

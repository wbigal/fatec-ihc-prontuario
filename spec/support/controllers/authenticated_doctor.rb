RSpec.configure do |config|
  config.before(:each, :authenticated_doctor) do
    pessoa = create(:pessoa, :with_account)
    create(:medico, pessoa: pessoa)
    controller.current_pessoa = pessoa
  end
end

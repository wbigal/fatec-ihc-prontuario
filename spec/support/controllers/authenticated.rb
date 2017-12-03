RSpec.configure do |config|
  config.before(:each, :authenticated) do
    pessoa = create(:pessoa, :with_account)
    controller.current_pessoa = pessoa
  end
end

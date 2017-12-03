print 'Creating Pessoa'

print '.'
Pessoa.create_with(
  nome_completo: 'Fabio Carille',
  data_nascimento: Date.new(1973, 9, 26),
  email: 'teste@fatec.ihc.prontuario',
  senha: 'ACB123'
).
find_or_create_by(cns: '1234567890123456')

print " done (total: #{Pessoa.count})\n"

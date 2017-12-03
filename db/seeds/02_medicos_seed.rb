print 'Creating Medico'

print '.'
Pessoa.create_with(
  nome_completo: 'Antônio Drauzio Varella',
  data_nascimento: Date.new(1943, 5, 3),
  email: 'medico@fatec.ihc.prontuario',
  senha: 'ACB123'
).
find_or_create_by(cns: '0234567890123456')

Pessoa.find_by(cns: '0234567890123456').create_medico(crm: 1910)

print " done (total: #{Medico.count})\n"

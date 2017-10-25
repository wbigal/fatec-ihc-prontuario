# Interação Humano-Computador - FATEC-SP

Este projeto é um prontuário eletrônico com o histórico de atendimentos de um cidadão, desenvolvido para a disciplina Interação Humano-Computador (IHC) da FATEC-SP. Ele .

## Setup

### Pré-requisitos

Para executar o projeto no seu ambiente de desenvolvemento você precisará atender os seguintes requisitos:

* Ter o RVM configurado e a versão 2.4.1 do Ruby já instalada
* Ter o bando de dados Postgres instalado

### Configurar ambiente

Para configurar seu ambiente de desenvolvimento execute as seguintes instruções:

```bash
cp .env.sample .env
rake db:setup
```

Edite o arquivo `.env` com os valores correspondentes ao seu ambiente de desenvolvimento.

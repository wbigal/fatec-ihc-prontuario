# Interação Humano-Computador - FATEC-SP

[ ![Codeship Status for wbigal/fatec-ihc-prontuario](https://app.codeship.com/projects/03e2c730-9c04-0135-d99c-3e0263b62404/status?branch=master)](https://app.codeship.com/projects/252855)
[![Maintainability](https://api.codeclimate.com/v1/badges/5070b48e6dc5b53922be/maintainability)](https://codeclimate.com/github/wbigal/fatec-ihc-prontuario/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/5070b48e6dc5b53922be/test_coverage)](https://codeclimate.com/github/wbigal/fatec-ihc-prontuario/test_coverage)

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

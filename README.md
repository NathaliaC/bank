## Instalação

👋 Olá, para que você consiga executar esse projeto na sua máquina é necessária a instação das seguintes dependências:
  
  - **🛠 Modo Desenvolvimento Docker**
    - git https://git-scm.com/
    - 🐳 [Docker](https://docs.docker.com/engine/installation/) Deve estar instalado.
    - 🐳 [Docker Compose](https://docs.docker.com/compose/) Deve estar instalado.
    - **💡 Dica:** [Documentação do Docker](https://docs.docker.com/)
    - curl: https://curl.haxx.se/ - Fazer requisições Rest 
    - postman: https://www.postman.com/ - Fazer requisições Rest com interface amigável.


#### Baixar o Projeto
```bash
git clone git@github.com:NathaliaC/bank.git
```

#### Entrar no Projeto
```bash
cd bank
```

#### Buildar o projeto
```bash
docker-compose build
```

#### Subir o serviço do projeto
```bash
docker-compose up
```

# 🚀  Desafio - Sistema de Contas bancárias

Desenvolver um sistema que irá gerenciar contas bancárias de clientes, permitindo fazer transferências de um cliente para outro e expor o saldo atual da conta, sempre em reais.

Gerar token da usuária Nathalia da API
```bash
curl -H 'Content-Type: application/json' -d '{"email": "nathalia@gmail.com", "password": "123456"}' -X POST http://localhost:3000/api/v1/authenticate
```
Gerar token do usuário Daniel da API
```bash
curl -H 'Content-Type: application/json' -d '{"email": "daniel@gmail.com", "password": "987654"}' -X POST http://localhost:3000/api/v1/authenticate
```

Abrir a conta Banco do Brasil
```bash
curl -H 'Content-Type: application/json' -d '{"name": "Banco do Brasil", "balance": 20000}' -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.kTK-XUjH-0bldAfIJibpHaDnVIDDT55ENMG6x7sc4Sc" -X POST 'http://localhost:3000/api/v1/bank_accounts'
```

Abrir a conta Bradesco
```bash
curl -H 'Content-Type: application/json' -d '{"id": 10, "name": "Bradesco", "balance": 50000}' -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.87PDGgKFbvj8bNJ0L7tFxKBZmNCTtqO7_3GehaeeEes" -X POST 'http://localhost:3000/api/v1/bank_accounts'
```

Fazer transferência da Conta Banco do Brasil
```bash
curl -H 'Content-Type: application/json' -d '{"source_account_id": 1, "destination_account_id": 10, "amount": 5000}' -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50X2lkIjoxfQ.KRMs73OnuzfAkJ2h_Vwt8SmFZfMUUmTLNg-tZ1RtFO8" -X POST 'http://localhost:3000/api/v1/bank_accounts/transfers'
```

Fazer transferência da Conta Bradesco
```bash
curl -H 'Content-Type: application/json' -d '{"source_account_id": 10, "destination_account_id": 1, "amount": 3000}' -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50X2lkIjoxMH0.YT85QX-csmn9xb6sgFUh2KlWuGJgbxqU4B0wAGnJzc0" -X POST 'http://localhost:3000/api/v1/bank_accounts/transfers'
```


Consultar Saldo Conta Banco do Brasil
```bash
curl -H 'Content-Type: application/json' -d '{"account_id": 1}' -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50X2lkIjoxfQ.KRMs73OnuzfAkJ2h_Vwt8SmFZfMUUmTLNg-tZ1RtFO8" -X POST 'http://localhost:3000/api/v1/bank_accounts/balances'
```

Consultar Saldo Conta Bradesco
```bash
curl -H 'Content-Type: application/json' -d '{"account_id": 10}' -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50X2lkIjoxMH0.YT85QX-csmn9xb6sgFUh2KlWuGJgbxqU4B0wAGnJzc0" -X POST 'http://localhost:3000/api/v1/bank_accounts/balances'
```

# Desafio de Movimentação de Contas


Estando na raiz do projeto execute
```bash
docker-compose run --rm app bundle exec bash
```

Acesse o diretório `calculate_balance` na pasta `scripts`.
```bash
cd scripts/calculate_balance/
```

Execute o script passando os arquivos `accounts.csv` e `transactions.csv`.
```bash
./calculate_balance.rb accounts.csv transactions.csv
```
#  Testes Lógicos

#### Questão 1

Paulo trabalha na recepção de uma empresa agenciadora de matrimônios, ele faz a primeira triagem das pessoas que procuram a agência e as encaminha para determinada sala de atendimento, dependendo da idade da pessoa. Até 25 anos, dois meses e 15 dias: sala 1, de 25 anos, 2 meses e 16 dias até 45 anos e 1 mês: sala 2, de 45 anos,1 mês e 1 dia até 65 anos: sala 3, mais velhos que isto na sala 4.

Faça um algoritmo que dada a data de nascimento descubra a sala correta. 

Estando na raiz do projeto execute
```bash
docker-compose run --rm app bundle exec bash
```

Acesse o diretório `attendance_room` na pasta `scripts`.
```bash
cd scripts/attendance_room/
```

Execute
```bash
./attendance_room.rb
```

#### Questão 2

Um professor citou as seguintes definições:
Número esotérico é todo número inteiro divisível por 3 e 5
Número cético é todo número inteiro que não é esotérico
Número primo é todo número inteiro divisível somente por 1 e ele mesmo

Faça um algoritmo que dado um número inteiro descubra se ele é Esotérico, Cético e/ou Primo


Estando na raiz do projeto execute
```bash
docker-compose run --rm app bundle exec bash
```

Acesse o diretório `categorize_number` na pasta `scripts`.
```bash
cd scripts/categorize_number/
```

Execute
```bash
./categoriza_number.rb
```

#### Questão 3

Considere como verdadeiras as seguintes afirmações:

Algumas pessoas são inescrupulosas
Os inescrupulosos são sempre amarelos ou verdes
Todo nervoso é vermelho
As baleias são verdes
Os rinocerontes são amarelos
Todas as pessoas são nervosas

Assinale com (V)erdadeiro ou (F)also.

<b>(F)</b> Todas as pessoas nervosas são inescrupulosas

<b>(V)</b> Se uma pessoa é verde ou amarela então ela é inescrupulosa

<b>(V)</b> As baleias são inescrupulosas

<b>(V)</b> Todas as pessoas são vermelhas

<b>(V)</b> Os rinocerontes são sempre inescrupulosos

<b>(V)</b> Os inescrupulosos são sempre pessoas ou baleias ou rinocerontes

<b>(V)</b> Se uma pessoa é inescrupulosa então ela é verde ou amarela

<b>(F)</b> Se algo é azul ou preto então este algo não é baleia, nem é nervoso e nem é rinoceronte

### Explicando

Considerando que todas as pessoas são nervosas e que todo nervoso é vermelho, logo todas as pessoas são vermelhas. 

Considerando que as pessoas inescrupulosas também são verdes e amareleas, eu conclui que as pessoas podem ter duas cores. Por isso (F) na última opção. 

Obrigada pela Atenção :)
Ruby Engineer Coding Challenge
 =======================

#### Apresentação

Olá, meu nome é Bruno Tavares, e esta é a minha solução para o desafio de desenvolvimento RUBY.

Optei pela utilização do banco de dados Postgresql e a execução dos testes com RSPEC.

Criei dois modelos, um no banco de dados e um em memória.

* O modelo DISTANCE foi criado para armazenar a distancia entre as cidades atendidas pelo sistema de entrega.
* O modelo SHIPPING foi criado apenas lógico pois não é necessário persistir a informação do custo de entrega no banco de dados, pois a taxa de entrega pode ser alterada sem a necessidade de atualizar toda a base de dados.

Criei dois controllers:

* DistanceController para ser responsável por receber o comando POST e criar um objeto no banco de dados do tipo DISTANCE, realizando a consistência necessária.
* ShippingController para ser o responsável por receber o comando GET e retornar ao solicitante o custo total da entrega de um item entre duas cidades de acordo com o peso do item.

Criei a excessão Shipping::PathNotFoundError customizada para representar o erro que podemos receber quando nenhum caminho é encontrado para a entrega entre duas cidades.

Criei o ExceptionHandler para controlar o retorno tratado em um JSON para os cenários de erro que a aplicação pode receber.

No application.yml estão parametrizados os seguintes valores:

* peso mínimo e máximo de um item a ser entregue
* taxa de entrega
* distancia mínima e máxima entre a cidade de origem e destino de uma entrega

Esta parametrização foi feita para que se for necessário alterar algum destes pontos, não será necessário realizar um novo deploy da aplicação.

#### Dependências

* Ruby 2.4.1
* Rails 5.2
* [dijkstra.gem](https://github.com/oscartanner/dijkstra.gem)
* PostgreSQL

### Preparando e rodando o Ambiente

* 1\. Instalar PostgreSQL
* 2\. Criar usuário para o postgres. Obs: no config database.yml consta as informações utilizadas neste projeto
* 3\. Instalar o Ruby
* 4\. Instalar o Bundler
* 5\. Executar ``` bundle install ```
* 6\. Rodar os testes com ``` bundle exec rspec ```
* 7\. Rodar a aplicação com ``` bundle exec rails s ```

## Funcionalidades da API

 ### Recursos

 ####POST /distance

 Cria ou atualiza um registro referente a distancia entre dois locais.

 Envio:

```{ "point_a": "Cidade 1", "point_b": "Cidade 2", "distance": 200 } ```

 Retorno com Sucesso (status 201):

 ```
 {
    "id": "021c7927-2737-4735-8e52-d3272b43eeea",
    "point_a": "Cidade 1",
    "point_b": "Cidade 2",
    "distance": 200,
    "created_at": "2018-08-05T02:34:13.055Z",
    "updated_at": "2018-08-05T02:52:33.844Z"
}
```

Retorno com Falha (status 412):

```
{
    "message": "Record invalid"
}
```

 ####GET /cost

 Obtem o custo efetivo para a entrega de um item de acordo com o peso e a distancia a ser percorrida considerando a menor distância possível.

 Envio:

```/cost?origin=Cidade1&destination=Cidade2&weight=10 ```

 Retorno com Sucesso (status 200):

 ```
{
    "origin": "Cidade1",
    "destination": "Cidade2",
    "weight": 10,
    "cost": 294.5
}
```

Retorno com Falha (status 412):

```
{
    "message": "Record invalid"
}
```

## Heroku

Esta API está disponível através das seguintes URL's

```
http://brunotavaresrakuten.herokuapp.com/distance/
```

```
http://brunotavaresrakuten.herokuapp.com/cost
```


[<img src="https://raw.githubusercontent.com/alemaocastro1986/ignite-challenge-one/main/assets/elixir_full.png" width="180"/>]() 
# Desafios Elixir - Chapter II
## Sobre
Desafios Ignite [Rocketseat](https://rocketseat.com.br/)  trilha elixir __Chapter II__ .


## Desafio 05 - Reservas de voos

Criar uma aplicação de reserva de voos, onde haverá o cadastro de usuários e o cadastro de reservas para um usuário.

A struct do usuário deverá possuir os seguintes campos:
```elixir
%User{
	id: id,
	name: name,
	email: email,
	cpf: cpf
}
```
A struct da reserva deverá possuir os seguintes campos:
```elixir
%Booking{
	id: id,
	data_completa: data_completa,
	cidade_origem: cidade_origem,
	cidade_destino: cidade_destino,
	id_usuario: id_usuario
}   
```

_obs: O campo `data_completa` deverá ser uma `NaiveDateTime`_.

***
 **Importante**: _É importante que todos os dados sejam salvos em um Agent_.
***

## Testando

```bash
mix test
```

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

## Funções 
```elixir
iex(1)> Flightex.create_user(%{
	name: "Elixander Erlangson", 
	email: "elix@flightex.com", 
	cpf: "88225912080"})   

{:ok, "ae4a1113-3593-4602-a8c1-ee9b6f318872"}

iex(2)> Flightex.create_booking (
	"0a1975a3-08d1-4899-94b5-f18836a566e1",
	 %{complete_date: "2021-04-22 09:00:00", 
	   origin_city: "Brazil - Porto Alegre", 
	   destination_city: "Japan - Tokio"})

{:ok, "9d181488-4d4f-4747-8f56-9bd35816cce5"}

iex(3)> Flightex.create_booking(
"0a1975a3-08d1-4899-94b5-f18836a566e2", 
%{complete_date: "2021-04-22 09:00:00", 
  origin_city: "Brazil - Porto Alegre", 
  destination_city: "Japan - Tokio"})

{:error, "User not found"}

iex(4)> Flightex.get_booking("9d181488-4d4f-4747-8f56-9bd35816cce5")

{:ok,
 %Flightex.Bookings.Booking{
   complete_date: ~N[2021-04-22 09:00:00], 
   destination_city: "Japan - Tokio",
   id: "9d181488-4d4f-4747-8f56-9bd35816cce5",
   id_user: "0a1975a3-08d1-4899-94b5-f18836a566e1",
   origin_city: "Brazil - Porto Alegre"
 }}

iex(5)> Flightex.get_booking("9d181488-4d4f-4747-8f56-9bd35816cce4")

{:error, "Flight booking not found."}


```

## Testando

```bash
mix test
```
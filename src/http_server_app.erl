-module(http_server_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
	Dispatch = cowboy_router:compile([
		{'_', [{"/", http_server_handler, []}]}
	]),
	{ok, _} = cowboy:start_clear(http_listener,
		[{port, 8080}],
		#{env => #{dispatch => Dispatch}}
	),
	http_server_sup:start_link().

stop(_State) ->
	ok = cowboy:stop_listener(http_listener).

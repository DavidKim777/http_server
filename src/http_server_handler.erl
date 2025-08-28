-module(http_server_handler).

-export([init/2]).

init(Req0, State) ->
  Method = cowboy_req:method(Req0),
  Path = cowboy_req:path(Req0),
  {ok, Body, _} = cowboy_req:read_body(Req0),
  Arg = http_server_protocol:decode(Body),
  {Reply, Arg1} = dispatch(Method, Path, Arg),
  StatusCode = case Reply of
    ok ->
      200;
    error ->
      500
  end,
  Json = http_server_protocol:encode(Arg1),
  Headers = #{<<"content-type">> => <<"application/json">>},
  Req = cowboy_req:reply(StatusCode, Headers, Json, Req0),
  {ok, Req, State}.

dispatch(<<"POST">>, Path, Arg) ->
  case Path of
    <<"/user/get_all">> ->
      http_server_api:get(Arg);
    <<"/user/create">> ->
      http_server_api:create(Arg)
  end.
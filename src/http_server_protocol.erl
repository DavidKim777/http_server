-module(http_server_protocol).

-export([decode/1, encode/1]).

decode(Arg) ->
  jsx:decode(Arg).

encode(Arg) ->
  jsx:encode(Arg).
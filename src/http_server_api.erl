-module(http_server_api).

-export([create/1, get/1]).


get(DecodeMap) ->
  Sql = "SELECT * FROM user WHERE name = $1 AND age = $2 LIMIT 10 OFFSET 10",
  Schema = #{
    <<"name">> => #{type => string, required => true},
    <<"age">>  => #{type => integer, min => 1}
  },
  case liver:validate(Schema, DecodeMap) of
    {ok, ValiData} ->
      Name = maps:get(<<"name">>, ValiData),
      Age = maps:get(<<"age">>, ValiData),
      Params = [Name, Age],
      {ok, Map} = query_db(Sql, Params),
      {ok, Map};
    {error, Errors} ->
      ErrorList = [
        #{field => Field, error => Reason}
        || {Field, Reason} <- Errors
      ],
      Map = #{status => "error", message => ErrorList},
      {error, Map}
  end.

create(DecodeMap) ->
  Sql = "INSERT INTO sports(name, age) VALUES ($1, $2)",
  Schema = #{
    <<"name">> => #{type => string, required => true},
    <<"age">>  => #{type => integer, min => 1}
  },case liver:validate(Schema, DecodeMap) of
        {ok, ValiData} ->
          Name = maps:get(<<"name">>, ValiData),
          Age = maps:get(<<"age">>, ValiData),
          Params = [Name, Age],
          {ok, Map} = query_db(Sql, Params),
          {ok, Map};
        {error, Errors} ->
          ErrorList = [
            #{field => Field, error => Reason}
            || {Field, Reason} <- Errors
          ],
          Map = #{status => "error", message => ErrorList},
          {error, Map}
      end.


query_db(Sql, Params) ->
  case http_server_db:query(Sql, Params) of
    {ok, _, Rows} ->
      Map = #{status => <<"success">>, data => Rows},
      {ok, Map};
    {error, Reason} ->
      lager:error("Database query failed: ~p", {Reason}),
      Map = #{status => <<"error">>, message => <<"Internal server error">> },
      {error, Map}
  end.
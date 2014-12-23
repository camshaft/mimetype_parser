-module(mimetype_parser).

-export([parse/1]).
-export([parse/2]).

parse(Src) ->
  parse(Src, 1).

parse(Src, LineNum) when is_integer(LineNum) ->
  case mimetype_parser_lexer:string(to_string(Src), LineNum) of
    {ok, Tokens, _} ->
      mimetype_parser_parser:parse(Tokens);
    Error ->
      Error
  end;
parse(Src, #{line := LineNum}) ->
  parse(Src, LineNum);
parse(Src, _) ->
  parse(Src, 1).

to_string(Bin) when is_list(Bin) ->
  Bin;
to_string(Bin) when is_binary(Bin) ->
  case unicode:characters_to_list(Bin) of
    L when is_list(L) ->
      L;
    _ ->
      binary_to_list(Bin)
  end.

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

parse_test_() ->
  Tests = [
    {<<"json">>, [{<<"application">>, <<"json">>, #{}}]},
    {<<"hyper+json">>, [{<<"application">>, <<"hyper+json">>, #{}}]},
    {<<"html">>, [{<<"text">>, <<"html">>, #{}}]},
    {<<"html, json">>, [{<<"text">>, <<"html">>, #{}},
                        {<<"application">>, <<"json">>, #{}}]},
    {<<"application/xml">>, [{<<"application">>, <<"xml">>, #{}}]},
    {<<"text/xml">>, [{<<"text">>, <<"xml">>, #{}}]},
    {<<"rdf; param=123">>, [{<<"application">>, <<"rdf+xml">>, #{<<"param">> => <<"123">>}}]},
    {<<"application/hyper+json; profile=users; version=1.0">>, [{<<"application">>, <<"hyper+json">>, #{<<"profile">> => <<"users">>, <<"version">> => <<"1.0">>}}]}
  ],
  [fun() -> {ok, E} = parse(I) end || {I, E} <- Tests].

-endif.

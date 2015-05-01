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

Definitions.

WS = (\s|\t|\r|\n)
Char = [^\(\)\<\>\@\,\;\:\\\"\/\[\]\?\=\+{WS}]+
QuotedChar = [^\\\"{WS}]+

Rules.

\,                                   :  {token, {',', TokenLine}}.

\+                                   :  {token, {'+', TokenLine}}.

\=                                   :  {token, {'=', TokenLine}}.

\;                                   :  {token, {';', TokenLine}}.

\/                                   :  {token, {'/', TokenLine}}.

{Char}                               :  {token, {token, TokenLine, to_lower(TokenChars)}}.

"{QuotedChar}+"                      :  {token, {token, TokenLine, remove_quote(TokenChars)}}.

{WS}                                 :  skip_token.

Erlang code.

to_lower(Str) ->
  list_to_binary(string:to_lower(Str)).

remove_quote(Str) ->
  list_to_binary(string:strip(Str, both, $")).

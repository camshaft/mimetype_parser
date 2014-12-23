Definitions.

WS = (\s|\t|\r|\n)
Char = [^\(\)\<\>\@\,\;\:\\\"\/\[\]\?\=\+{WS}]+

Rules.

\,                                   :  {token, {',', TokenLine}}.

\+                                   :  {token, {'+', TokenLine}}.

\=                                   :  {token, {'=', TokenLine}}.

\;                                   :  {token, {';', TokenLine}}.

\/                                   :  {token, {'/', TokenLine}}.

{Char}                               :  {token, {token, TokenLine, to_lower(TokenChars)}}.

{WS}                                 :  skip_token.

Erlang code.

to_lower(Str) ->
  list_to_binary(string:to_lower(Str)).

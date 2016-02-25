Nonterminals

mediatypes
mediatype
arguments
argument
.

Terminals
token
','
'='
';'
'/'
.

Rootsymbol mediatypes.

mediatypes ->
  mediatype :
  ['$1'].
mediatypes ->
  mediatype ',' mediatypes :
  ['$1' | '$3'].

mediatype ->
  token :
  {?type('$1'), ?short('$1'), #{}}.
mediatype ->
  token '/' token :
  {?value('$1'), ?value('$3'), #{}}.
mediatype ->
  token arguments :
  {?type('$1'), ?short('$1'), '$2'}.
mediatype ->
  token '/' token arguments :
  {?value('$1'), ?value('$3'), '$4'}.

arguments ->
  ';' argument :
  '$2'.
arguments ->
  ';' argument arguments :
  maps:merge('$3', '$2').

argument ->
  token '=' token :
  maps:from_list([{?value('$1'), ?value('$3')}]).

Erlang code.

-define(type(Tup), type(?value(Tup))).
-define(value(Tup), element(3, Tup)).
-define(short(Tup), subtype(?value(Tup))).
-define(subtype(Pre, Post), <<(?value(Pre))/binary, "+", (?value(Post))/binary>>).

%% convert a short type to the full type
type(<<"gif">>) ->
  <<"image">>;
type(<<"jpeg">>) ->
  <<"image">>;
type(<<"png">>) ->
  <<"image">>;
type(<<"tiff">>) ->
  <<"image">>;
type(<<"svg">>) ->
  <<"image">>;

type(<<"http">>) ->
  <<"message">>;

type(<<"form-data">>) ->
  <<"multipart">>;
type(<<"mixed">>) ->
  <<"multipart">>;

type(<<"html">>) ->
  <<"text">>;
type(<<"css">>) ->
  <<"text">>;
type(<<"csv">>) ->
  <<"text">>;
type(<<"rtf">>) ->
  <<"text">>;
type(<<"vcard">>) ->
  <<"text">>;
type(<<"text">>) ->
  <<"text">>;

type(<<"avi">>) ->
  <<"video">>;
type(<<"mpeg">>) ->
  <<"video">>;
type(<<"mp4">>) ->
  <<"video">>;
type(<<"webm">>) ->
  <<"video">>;

type(_) ->
  <<"application">>.

%% convert a short type to the full subtype
subtype(<<"binary">>) ->
  <<"octet-stream">>;

subtype(<<"text">>) ->
  <<"plain">>;

subtype(<<"svg">>) ->
  <<"svg+xml">>;
subtype(<<"atom">>) ->
  <<"atom+xml">>;
subtype(<<"rss">>) ->
  <<"rss+xml">>;
subtype(<<"rdf">>) ->
  <<"rdf+xml">>;

subtype(Subtype) ->
  Subtype.

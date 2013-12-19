-module(torrentel_parser).
-author("johnvp").

-export([parse/2]).
-record(torrent, {url = ""}).

%%parse(<<$d, Rest/binary>>, #torrent{} = Torrent) ->
%%  #torrent{url = ""}.


parse(<<$d, Rest/binary>>, Torrent) ->
  Torrent#torrent{url = ""}.
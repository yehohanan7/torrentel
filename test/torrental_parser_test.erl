-module(torrental_parser_test).
-author("johnvp").

-include_lib("eunit/include/eunit.hrl").
-record(torrent, {url = ""}).

simple_test() ->
  ?assert(true).


parser_test() ->
  {ok, Data} = file:read_file("/Users/johnvp/dev/torrentel/test/test_torrent.torrent"),
  #torrent{url = Url} = torrentel_parser:parse(Data, #torrent{}),
  ?assertEqual(Url, "").

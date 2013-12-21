-module(parser_test).
-author("johnvp").

-include_lib("eunit/include/eunit.hrl").

simple_test() ->
  ?assert(true).


parser_test() ->
  {ok, Data} = file:read_file("/Users/johnvp/dev/torrentel/test/test_torrent.torrent"),
  {ok, Dict} = parser:parse(Data),
  ?assert(dict:size(Dict) > 0).

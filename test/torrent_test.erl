-module(torrent_test).
-author("johnvp").

-include_lib("eunit/include/eunit.hrl").

should_fetch_torrent_meta_info_test() ->
  {ok, Data} = file:read_file("/Users/johnvp/dev/torrentel/test/test_torrent.torrent"),
  torrent:init(test_torrent, Data),
  ?assert(torrent:announce(test_torrent) =:= 'http://tracker.thepiratebay.org/announce').

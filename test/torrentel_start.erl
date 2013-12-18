-module(torrentel_start).
-author("johnvp").

-include_lib("eunit/include/eunit.hrl").

start_test() ->
  ?assert(ok =:= application:start(torrentel)).

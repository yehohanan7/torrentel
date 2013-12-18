./rebar get-deps
./rebar compile
erl
  application:load(torrentel).
  application:start(torrentel).


./rebar eunit skip_deps=true
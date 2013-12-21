-module(torrent).
-author("johnvp").

-behaviour(gen_server).

-export([start_link/0, init/2, announce/1, announce_list/1]).

-export([init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3]).

-define(SERVER, ?MODULE).
-define(TORRENT, ?MODULE).

start_link() ->
  gen_server:start_link({local, ?TORRENT}, ?MODULE, [], []).

init([]) ->
  {ok, dict:new()}.

handle_call({Key, Name}, _From, Files) ->
  {reply, dict:fetch(atom_to_binary(Key, utf8), dict:fetch(Name, Files)), Files}.

handle_cast({parse, Name, Data}, Files) ->
  {ok, Dict} = parser:parse(Data),
  {noreply, dict:store(Name, Dict, Files)}.

handle_info(_Info, _Files) ->
  {noreply, _Files}.

terminate(_Reason, _Files) ->
  ok.

code_change(_OldVsn, Files, _Extra) ->
  {ok, Files}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

init(Name, Data) ->
  gen_server:cast(?TORRENT, {parse, Name, Data}).

announce(Name) ->
  AnnounceUrl = gen_server:call(?TORRENT, {announce, Name}),
  binary_to_atom(AnnounceUrl, utf8).

announce_list(Name) ->
  gen_server:call(?TORRENT, {'announce-list', Name}).
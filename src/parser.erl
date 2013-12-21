-module(parser).
-author("johnvp").

-export([parse/1]).

parse(Data) ->
  try parseData(Data) of
    {Value, _} ->
      {ok, Value}
  catch
    exit:Reason ->
      io:format("erbit_parser:bencodeData ->problem(~p) processing data ~n", [Reason]),
      {error, unparsed};
    Error:Reason2 ->
      io:format("erbit_parser:bencodeData ->problem(~p ~p) processing data ~n", [Error, Reason2]),
      {error, Error, Reason2}
  end.

parseData(<<$d, Tail/binary>>) ->
  parseDictionary(Tail, dict:new());
parseData(<<$l, Tail/binary>>) ->
  parseList(Tail, []);
parseData(<<$i, Tail/binary>>) ->
  parseInteger(Tail, []);
parseData(_String) ->
  parseString(_String, []).

parseDictionary(<<$e, Tail/binary>>, Acc) ->
  {Acc, Tail};
parseDictionary(Data, Acc) ->
  {Key, _Tail} = parseData(Data),
  {Value, Tail} = parseData(_Tail),
  parseDictionary(Tail, dict:store(Key, Value, Acc)).

parseList(<<$e, Tail/binary>>, Acc) ->
  {lists:reverse(Acc), Tail};
parseList(Data, Acc) ->
  {Value, Tail} = parseData(Data),
  parseList(Tail, [Value | Acc]).

parseInteger(<<$e, Tail/binary>>, Acc) ->
  {list_to_integer(lists:reverse(Acc)), Tail};
parseInteger(<<X, Tail/binary>>, Acc) ->
  parseInteger(Tail, [X | Acc]).

parseString(<<$:, Tail/binary>>, Acc) ->
  CharacterNumber = list_to_integer(lists:reverse(Acc)),
  <<String:CharacterNumber/binary, _Tail/binary>> = Tail,
  {String, _Tail};
parseString(<<X, Tail/binary>>, Acc) ->
  parseString(Tail, [X | Acc]).
